
using Furion.DataEncryption;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using MiniExcelLibs;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;
using Yitter.IdGenerator;

namespace Magic.Core.Service;

/// <summary>
/// 用户服务
/// </summary>
[ApiDescriptionSettings(Name = "User", Order = 150)]
public class SysUserService : ISysUserService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysUser> _sysUserRep;  // 用户表仓储 

    private readonly ISysCacheService _sysCacheService;
    private readonly ISysConfigService _sysConfigService;
    private readonly ISysEmpService _sysEmpService;
    private readonly ISysUserDataScopeService _sysUserDataScopeService;
    private readonly ISysUserRoleService _sysUserRoleService;

    public SysUserService(SqlSugarRepository<SysUser> sysUserRep,
                          ISysCacheService sysCacheService,
                          ISysEmpService sysEmpService,
                          ISysUserDataScopeService sysUserDataScopeService,
                          ISysUserRoleService sysUserRoleService,
                          ISysConfigService sysConfigService)
    {
        _sysUserRep = sysUserRep;
        _sysCacheService = sysCacheService;
        _sysEmpService = sysEmpService;
        _sysUserDataScopeService = sysUserDataScopeService;
        _sysUserRoleService = sysUserRoleService;
        _sysConfigService = sysConfigService;
    }

    /// <summary>
    /// 分页查询用户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/page")]
    public async Task<dynamic> QueryUserPageList([FromQuery] UserInput input)
    {
        var superAdmin = UserManager.IsSuperAdmin;
        var searchValue = input.SearchValue;
        var pid = input.SysEmpParam.OrgId;
        var users = await _sysUserRep.AsQueryable().InnerJoin<SysEmp>((u, e) => u.Id == e.Id)
            .InnerJoin<SysOrg>((u, e, o)=> e.OrgId == o.Id)
            .InnerJoin<SysTenant>((u, e, o, t) => u.TenantId == t.Id)
            .WhereIF(!string.IsNullOrWhiteSpace(searchValue), (u, e, o) => u.Account.Contains(input.SearchValue.Trim()) ||
                                                                        u.Name.Contains(input.SearchValue.Trim()) ||
                                                                        u.Phone.Contains(input.SearchValue.Trim()))
            .WhereIF(!string.IsNullOrWhiteSpace(pid), (u, e, o) => e.OrgId == long.Parse(pid) ||
                                                                    o.Pids.Contains(pid.Trim()))
            .WhereIF(Enum.IsDefined(typeof(CommonStatus), input.SearchStatus), (u, e, o) => u.Status == input.SearchStatus)
            .Where((u, e, o) => u.AdminType == AdminType.None)
            .Select<UserOutput>("u.*,t.Name As TenantName ").ToDataFilter("u","Id",FilterType.User).ToPagedListAsync(input.PageNo, input.PageSize);

        var empInfos =await _sysEmpService.GetEmpInfo(users.Items.Select(m => long.Parse(m.Id)).ToList());
        foreach (var user in users.Items)
        {
            user.SysEmpInfo = empInfos.FirstOrDefault(m => m.Id == long.Parse(user.Id));
        }

        //foreach (var user in users.Items)
        //{
        //    user.SysEmpInfo = await _sysEmpService.GetEmpInfo(long.Parse(user.Id));
        //}
        return users.XnPagedResult();
    }

    /// <summary>
    /// 增加用户       
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/add")]
    public async Task AddUser(AddUserInput input)
    {
        // 数据范围检查
        CheckDataScope(input.SysEmpParam == null || string.IsNullOrEmpty(input.SysEmpParam.OrgId) ? 0 : long.Parse(input.SysEmpParam.OrgId));

        var isExist = await _sysUserRep.AnyAsync(u => u.Account == input.Account);
        if (isExist) throw Oops.Oh(ErrorCode.D1003);

        var user = input.Adapt<SysUser>();
        user.AdminType = AdminType.None;
        user.Password = MD5Encryption.Encrypt(input.Password);
        if (string.IsNullOrEmpty(user.Name))
            user.Name = user.Account;
        if (string.IsNullOrEmpty(user.NickName))
            user.NickName = user.Account;

        try
        {
            _sysUserRep.CurrentBeginTran();
            var newUser = await _sysUserRep.InsertReturnEntityAsync(user);
            input.SysEmpParam.Id = newUser.Id.ToString();
            // 增加员工信息
            await _sysEmpService.AddOrUpdate(input.SysEmpParam);
            _sysUserRep.CurrentCommitTran();
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        }
        catch (Exception)
        {
            _sysUserRep.CurrentRollbackTran();
            throw;
        }


    }

    /// <summary>
    /// 删除用户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/delete")]
    public async Task DeleteUser(DeleteUserInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (user.AdminType != AdminType.None)
            throw Oops.Oh(ErrorCode.D1014);

        if (user.Account == UserManager.Account)
        {
            throw Oops.Oh(ErrorCode.D1001);
        }

        // 数据范围检查
        CheckDataScopeByUserId(input.Id);

        try
        {
            _sysUserRep.CurrentBeginTran();
            // 直接删除用户
            await _sysUserRep.AsUpdateable(new SysUser {IsDeleted = true}).UpdateColumns(user.FalseDeleteColumn()).Where(wh => wh.Id == user.Id).ExecuteCommandAsync();

            // 删除员工及附属机构职位信息
            await _sysEmpService.DeleteEmpInfoByUserId(user.Id);

            //删除该用户对应的用户-角色表关联信息
            await _sysUserRoleService.DeleteUserRoleListByUserId(user.Id);

            //删除该用户对应的用户-数据范围表关联信息
            await _sysUserDataScopeService.DeleteUserDataScopeListByUserId(user.Id);
            _sysUserRep.CurrentCommitTran();
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        }
        catch (Exception)
        {
            _sysUserRep.CurrentRollbackTran();
            throw;
        }



    }

    /// <summary>
    /// 更新用户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/edit")]
    public async Task UpdateUser(UpdateUserInput input)
    {
        // 数据范围检查
        CheckDataScopeByUserId(input.Id);

        // 排除自己并且判断与其他是否相同
        var isExist = await _sysUserRep.AnyAsync(u => u.Account == input.Account && u.Id != input.Id);
        if (isExist) throw Oops.Oh(ErrorCode.D1003);

        var user = input.Adapt<SysUser>();

        try
        {
            _sysUserRep.CurrentBeginTran();
            await _sysUserRep.AsUpdateable(user).IgnoreColumns(it => new { it.Password, it.Status, it.AdminType }).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
            input.SysEmpParam.Id = user.Id.ToString();
            // 更新员工及附属机构职位信息
            await _sysEmpService.AddOrUpdate(input.SysEmpParam);
            _sysUserRep.CurrentCommitTran();
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        }
        catch (Exception)
        {
            _sysUserRep.CurrentRollbackTran();
            throw;
        }


    }

    /// <summary>
    /// 查看用户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/detail")]
    public async Task<dynamic> GetUser([FromQuery] QueryUserInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        var userDto = user.Adapt<UserOutput>();
        if (userDto != null)
        {
            userDto.SysEmpInfo = await _sysEmpService.GetEmpInfo(user.Id);
        }
        return userDto;
    }

    /// <summary>
    /// 修改用户状态
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/changeStatus")]
    public async Task ChangeUserStatus(UpdateUserInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (user.AdminType == AdminType.SuperAdmin)
            throw Oops.Oh(ErrorCode.D1015);

        if (!Enum.IsDefined(typeof(CommonStatus), input.Status))
            throw Oops.Oh(ErrorCode.D3005);
        user.Status = input.Status;
        await _sysUserRep.AsUpdateable(user).ExecuteCommandAsync();
    }

    /// <summary>
    /// 授权用户角色
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/grantRole")]
    public async Task GrantUserRole(UpdateUserInput input)
    {
        // 数据范围检查
        CheckDataScopeByUserId(input.Id);
        await _sysUserRoleService.GrantRole(input);
    }

    /// <summary>
    /// 授权用户数据范围
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/grantData")]
    public async Task GrantUserData(UpdateUserInput input)
    {
        // 清除缓存
        await _sysCacheService.DelAsync(CommonConst.CACHE_KEY_DATASCOPE + $"{input.Id}");
        await _sysCacheService.DelAsync(CommonConst.CACHE_KEY_USERSDATASCOPE + $"{input.Id}");
        // 数据范围检查
        CheckDataScopeByUserId(input.Id);
        await _sysUserDataScopeService.GrantData(input);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
    }

    /// <summary>
    /// 更新用户信息
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/updateInfo")]
    public async Task UpdateUserInfo(UpdateUserInput input)
    {
        var user = input.Adapt<SysUser>();
        await _sysUserRep.AsUpdateable(user)
            .IgnoreColumns(ignoreAllNullColumns: true)
            .IgnoreColumns(it => new { it.AdminType, it.LastLoginTime })
            .ExecuteCommandAsync();
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
    }

    /// <summary>
    /// 修改用户密码
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/updatePwd")]
    public async Task UpdateUserPwd(ChangePasswordUserInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (MD5Encryption.Encrypt(input.Password) != user.Password)
            throw Oops.Oh(ErrorCode.D1004);
        user.Password = MD5Encryption.Encrypt(input.NewPassword);
        await _sysUserRep.AsUpdateable(user).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取用户拥有角色
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/ownRole")]
    public async Task<dynamic> GetUserOwnRole([FromQuery] QueryUserInput input)
    {
        return await _sysUserRoleService.GetUserRoleIdList(input.Id);
    }

    /// <summary>
    /// 获取用户拥有数据
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/ownData")]
    public async Task<dynamic> GetUserOwnData([FromQuery] QueryUserInput input)
    {
        return await _sysUserDataScopeService.GetUserDataScopeIdList(input.Id);
    }

    /// <summary>
    /// 重置用户密码
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/resetPwd")]
    public async Task ResetUserPwd(QueryUserInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        user.Password = MD5Encryption.Encrypt(await _sysConfigService.GetDefaultPassword());
        await _sysUserRep.AsUpdateable(user).IgnoreColumns(it => new { it.AdminType }).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 修改用户头像
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/updateAvatar")]
    public async Task UpdateAvatar(UploadAvatarInput input)
    {
        var user = await _sysUserRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        user.Avatar = input.Avatar.ToString();
        await _sysUserRep.AsUpdateable(user).IgnoreColumns(it => new { it.AdminType }).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取用户选择器
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/selector")]
    public async Task<dynamic> GetUserSelector([FromQuery] UserInput input)
    {
        return await _sysUserRep.AsQueryable()
                               .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => (u.Name.Contains(input.Name.Trim())))
                               .Where(u => u.Status != CommonStatus.DELETED)
                               .Where(u => u.AdminType != AdminType.SuperAdmin)
                               .Select(u => new
                               {
                                   u.Id,
                                   u.Name
                               }).ToListAsync();
    }

    /// <summary>
    /// 用户导出
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysUser/export")]
    public async Task<IActionResult> ExportUser([FromQuery] UserInput input)
    {
        
        //这里如果报错看下AdminType的值 不能是0，必须是在枚举值内的
        var users = await _sysUserRep.ToListAsync();
        if(!users.Any())
            throw Oops.Oh("没有数据");
        var memoryStream = new MemoryStream();
        memoryStream.SaveAs(users);
        memoryStream.Seek(0, SeekOrigin.Begin);
        return await Task.FromResult(new FileStreamResult(memoryStream, "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet")
        {
            FileDownloadName = "user.xlsx"
        });
    }

    /// <summary>
    /// 用户导入
    /// </summary>
    /// <param name="file"></param>
    /// <returns></returns>
    [HttpPost("/sysUser/import")]
    public async Task ImportUser(IFormFile file)
    {
        var path = Path.Combine(Path.GetTempPath(), $"{YitIdHelper.NextId()}.xlsx");
        using (var stream = File.Create(path))
        {
            await file.CopyToAsync(stream);
        }
        throw Oops.Oh("请自行完善入库操作");

        //var rows = MiniExcel.Query(path); // 解析
        //foreach (var row in rows)
        //{
        //    var a = row.A;
        //    var b = row.B;
        //    // 入库等操作

        //}
    }

    /// <summary>
    /// 根据用户Id获取用户
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>       
    [NonAction]
    public async Task<dynamic> GetUserById(long userId)
    {
        return await _sysUserRep.FirstOrDefaultAsync(u => u.Id == userId);
    }

    /// <summary>
    /// 将OAuth账号转换成账号
    /// </summary>
    /// <param name="authUser"></param>
    /// <param name="sysUser"></param>
    /// <returns></returns>
    [NonAction]
    public async Task SaveAuthUserToUser(AuthUserInput authUser, UserInput sysUser)
    {
        var user = sysUser.Adapt<SysUser>();
        user.AdminType = AdminType.None; // 非管理员

        // oauth账号与系统账号判断
        var isExist = await _sysUserRep.AnyAsync(u => u.Account == authUser.Username);
        user.Account = isExist ? authUser.Username + DateTime.Now.Ticks : authUser.Username;
        user.Name = user.NickName = authUser.Nickname;
        user.Email = authUser.Email;
        user.Sex = authUser.Gender;
        await _sysUserRep.InsertAsync(user);
    }

    /// <summary>
    /// 获取用户数据范围（机构Id集合）并缓存
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>       
    [NonAction]
    public async Task<List<long>> GetUserDataScopeIdList(long userId = 0)
    {
        userId = userId <= 0 ? UserManager.UserId : userId;
        var dataScopes = await _sysCacheService.GetDataScope(userId); // 先从缓存里面读取
        if (dataScopes == null || dataScopes.Count < 1)
        {
            if (!UserManager.IsSuperAdmin && !UserManager.IsTenantAdmin)
            {
                var orgId = await _sysEmpService.GetEmpOrgId(userId);
                // 获取该用户对应的数据范围集合
                var userDataScopeIdListForUser = await _sysUserDataScopeService.GetUserDataScopeIdList(userId);
                // 获取该用户的角色对应的数据范围集合
                var userDataScopeIdListForRole = await _sysUserRoleService.GetUserRoleDataScopeIdList(userId, orgId);
                dataScopes = userDataScopeIdListForUser.Concat(userDataScopeIdListForRole).Distinct().ToList(); // 并集
            }
            else
            {
                dataScopes = await _sysUserRep.Change<SysOrg>().AsQueryable().Select(u => u.Id).ToListAsync();
            }
            await _sysCacheService.SetDataScope(userId, dataScopes); // 缓存结果
        }
        return dataScopes;
    }

    /// <summary>
    /// 检查普通用户数据范围
    /// </summary>
    /// <param name="orgId"></param>
    /// <returns></returns>
    [NonAction]
    public async void CheckDataScope(long orgId)
    {
        // 如果当前用户不是超级管理员，则进行数据范围校验
        if (!UserManager.IsSuperAdmin)
        {
            var dataScopes = await GetUserDataScopeIdList(UserManager.UserId);
            if (dataScopes == null ||orgId <= 0|| !dataScopes.Contains(orgId))
                throw Oops.Oh(ErrorCode.D1013);
        }
    }
    /// <summary>
    /// 获取用户数据范围（用户Id集合）
    /// </summary>
    /// <returns></returns>
    [NonAction]
    public async Task<List<long>> GetDataScopeIdUserList(long userId = 0)
    {
        userId = userId<=0? UserManager.UserId: userId;
        var list = await _sysCacheService.GetUsersDataScope(userId); // 先从缓存里面读取
        if (list == null || list.Count < 1)
			{
            var dataScopes = await GetUserDataScopeIdList(userId);
            list = (await _sysEmpService.HasOrgEmp(dataScopes)).Select(a => a.Id).ToList();
            list.Add(userId);
            list = list.Distinct().ToList();
            await _sysCacheService.SetUsersDataScope(userId, list); // 缓存结果
        }
        return list;
    }

    /// <summary>
    /// 检查普通用户数据范围
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    [NonAction]
    public async void CheckDataScopeByUserId(long userId)
    {
        // 如果当前用户不是超级管理员，则进行数据范围校验
        if (!UserManager.IsSuperAdmin)
        {
            var dataScopes = await GetDataScopeIdUserList(UserManager.UserId);
            if (dataScopes == null || userId <= 0 || !dataScopes.Contains(userId))
                throw Oops.Oh(ErrorCode.D1013);
        }
    }
}
