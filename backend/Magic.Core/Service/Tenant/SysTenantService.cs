

using Furion.DataEncryption;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 租户服务
/// </summary>
[ApiDescriptionSettings(Name = "Tenant", Order = 100)]
public class SysTenantService : ISysTenantService, IDynamicApiController, ITransient
{

    private readonly SqlSugarRepository<SysTenant> _sysTenantRep;    // 租户表仓储
    private readonly SqlSugarRepository<SysUser> _sysUserRep;
    private readonly SqlSugarRepository<SysOrg> _sysOrgRep;
    private readonly SqlSugarRepository<SysRole> _sysRoleRep;
    private readonly SqlSugarRepository<SysEmp> _sysEmpRep;
    private readonly SqlSugarRepository<SysPos> _sysPosRep;
    private readonly SqlSugarRepository<SysEmpPos> _sysEmpPosRep;
    private readonly SqlSugarRepository<SysUserRole> _sysUserRoleRep;
    private readonly SqlSugarRepository<SysUserDataScope> _sysUserDataScopeRep;
    private readonly SqlSugarRepository<SysRoleDataScope> _sysRoleDataScopeRep;
    private readonly ISysCacheService _sysCacheService;

    private readonly ISysRoleMenuService _sysRoleMenuService;
    private readonly ISysUserRoleService _sysUserRoleService;
    private readonly ISysConfigService _sysConfigService;

    public SysTenantService(
                            ISqlSugarClient sqlSugarClient,
                            SqlSugarRepository<SysTenant> sysTenantRep,
                            SqlSugarRepository<SysOrg> sysOrgRep,
                            SqlSugarRepository<SysRole> sysRoleRep,
                            SqlSugarRepository<SysEmp> sysEmpRep,
                            SqlSugarRepository<SysPos> sysPosRep,
                            SqlSugarRepository<SysUser> sysUserService,
                            SqlSugarRepository<SysEmpPos> sysEmpPosRep,
                            SqlSugarRepository<SysUserRole> sysUserRoleRep,
                            SqlSugarRepository<SysUserDataScope> sysUserDataScopeRep,
                            SqlSugarRepository<SysRoleDataScope> sysRoleDataScopeRep,
                            ISysRoleMenuService sysRoleMenuService,
                            ISysUserRoleService sysUserRoleService,
                             ISysConfigService sysConfigService,
                             ISysCacheService sysCacheService
                            )
    {
        _sysTenantRep = sysTenantRep;
        _sysOrgRep = sysOrgRep;
        _sysRoleRep = sysRoleRep;
        _sysEmpRep = sysEmpRep;
        _sysPosRep = sysPosRep;
        _sysUserRep = sysUserService;
        _sysEmpPosRep = sysEmpPosRep;
        _sysUserRoleRep = sysUserRoleRep;
        _sysUserDataScopeRep = sysUserDataScopeRep;
        _sysRoleDataScopeRep = sysRoleDataScopeRep;
        _sysRoleMenuService = sysRoleMenuService;
        _sysUserRoleService = sysUserRoleService;
        _sysConfigService = sysConfigService;
        _sysCacheService = sysCacheService;
    }

    /// <summary>
    /// 分页查询租户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysTenant/page")]
    public async Task<dynamic> QueryTenantPageList([FromQuery] TenantInput input)
    {
        var tenants = await _sysTenantRep.AsQueryable()
                                         .Where(m => m.TenantType != TenantTypeEnum.SYSTEM)
                                         .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
                                         .WhereIF(!string.IsNullOrWhiteSpace(input.Host), u => u.Host.Contains(input.Host.Trim()))
                                         .Select<TenantOutput>()
                                         .ToPagedListAsync(input.PageNo, input.PageSize);
        return tenants.XnPagedResult();
    }

    /// <summary>
    /// 增加租户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysTenant/add")]
    public async Task AddTenant(AddTenantInput input)
    {
        var isExist = await _sysTenantRep.AnyAsync(u => u.Name == input.Name || u.Host == input.Host || u.Email == input.Email);
        if (isExist)
            throw Oops.Oh(ErrorCode.D1300);

        var tenant = input.Adapt<SysTenant>();
        tenant.TenantType = TenantTypeEnum.COMMON;
        var newTenant = await _sysTenantRep.InsertReturnEntityAsync(tenant);
        await InitNewTenant(newTenant);
    }

    /// <summary>
    /// 新增租户时，初始化数据
    /// </summary>
    /// <param name="newTenant"></param>
    public async Task InitNewTenant(SysTenant newTenant)
    {
        long tenantId = newTenant.Id;
        string email = newTenant.Email;
        string companyName = newTenant.Name;


        // 初始化公司（组织结构）
        var newOrg = new SysOrg
        {
            TenantId = tenantId,
            Pid = 0,
            Pids = "[0],",
            Name = companyName,
            Code = "1",
            Contacts = newTenant.AdminName,
            Tel = newTenant.Phone
        };
        newOrg = await _sysOrgRep.InsertReturnEntityAsync(newOrg);


        // 初始化角色
        var newRole = new SysRole
        {
            TenantId = tenantId,
            DataScopeType = DataScopeType.ALL,
            Code = "1",
            Name = "系统管理员",
            RoleType = RoleType.AdminRole
        };

        newRole = await _sysRoleRep.InsertReturnEntityAsync(newRole);

        // 初始化租户管理员
        var newUser = new SysUser
        {
            TenantId = tenantId,
            Account = email,
            Password = "e10adc3949ba59abbe56e057f20f883e",
            Name = newTenant.AdminName,
            NickName = newTenant.AdminName,
            Email = newTenant.Email,
            Phone = newTenant.Phone,
            AdminType = AdminType.Admin,
            Sex=Gender.MALE
        };
        newUser = await _sysUserRep.InsertReturnEntityAsync(newUser);

        // 初始化职工
        var sysEmp = new SysEmp
        {
            Id = newUser.Id,
            JobNum = "1",
            OrgId = newOrg.Id,
            OrgName = newOrg.Name
        };
        await _sysEmpRep.InsertAsync(sysEmp);

        //初始化用户角色
        var sysUserRole = new SysUserRole
        {
            SysUserId = newUser.Id,
            SysRoleId = newRole.Id
        };
        await _sysUserRoleRep.InsertAsync(sysUserRole);

        //初始化用户机构
        var sysUserDataScope = new SysUserDataScope
        {
            SysUserId = newUser.Id,
            SysOrgId = newOrg.Id
        };
        await _sysUserDataScopeRep.InsertAsync(sysUserDataScope);

        var sysRoleDataScope = new SysRoleDataScope
        {
            SysOrgId = newOrg.Id,
            SysRoleId = newRole.Id
        };
        await _sysRoleDataScopeRep.InsertAsync(sysRoleDataScope);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
    }

    /// <summary>
    /// 删除租户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysTenant/delete")]
    public async Task DeleteTenant(DeleteTenantInput input)
    {
        SysTenant sysTenant = await GetTenant(new QueryTenantInput() { Id = input.Id });
        List<SysUser> userList = await _sysUserRep.AsQueryable().Filter(null, true).Where(m => m.TenantId == input.Id).ToListAsync();
        sysTenant.IsDeleted = true;

        try
        {
            _sysUserRep.CurrentBeginTran();
            await _sysTenantRep.UpdateAsync(sysTenant);

            if (userList.Any())
            {
                userList.ForEach(m => { m.IsDeleted = true; });
                await _sysUserRep.UpdateAsync(userList);
            }
            _sysUserRep.CurrentCommitTran();
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
        }
        catch (System.Exception)
        {
            _sysUserRep.CurrentRollbackTran();
        }


    }

    /// <summary>
    /// 更新租户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysTenant/edit")]
    public async Task UpdateTenant(UpdateTenantInput input)
    {
        var isExist = await _sysTenantRep.AnyAsync(u => (u.Name == input.Name || u.Host == input.Host || u.Email == input.Email) && u.Id != input.Id && u.TenantType != TenantTypeEnum.SYSTEM);
        if (isExist)
            throw Oops.Oh(ErrorCode.D1300);

        var tenant = input.Adapt<SysTenant>();
        tenant.TenantType = TenantTypeEnum.COMMON;
        await _sysTenantRep.AsUpdateable(tenant).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
    }

    /// <summary>
    /// 获取租户
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysTenant/detail")]
    public async Task<SysTenant> GetTenant([FromQuery] QueryTenantInput input)
    {
        var sysTenant = await _sysTenantRep.AsQueryable().FirstAsync(u => u.Id == input.Id && u.TenantType != TenantTypeEnum.SYSTEM);
        if (sysTenant == null)
            throw Oops.Oh(ErrorCode.D1002);
        return sysTenant;
    }

    /// <summary>
    /// 授权租户管理员角色菜单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysTenant/grantMenu")]
    public async Task GrantMenu(GrantRoleMenuInput input)
    {
        var tenantAdminUser = await GetTenantAdminUser(input.Id);
        if (tenantAdminUser == null) return;
        var roleIds = await _sysUserRoleService.GetUserRoleIdList(tenantAdminUser.Id);
        input.Id = roleIds[0]; // 重置租户管理员角色Id
        await _sysRoleMenuService.GrantMenu(input);
        //处理该租户下角色的权限
        await _sysRoleMenuService.ClearRoleMenuListByTenantId(tenantAdminUser.TenantId.Value, input.Id);
    }

    /// <summary>
    /// 获取租户管理员角色拥有菜单Id集合
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysTenant/ownMenu")]
    public async Task<List<OwnMenuOutput>> OwnMenu([FromQuery] QueryTenantInput input)
    {
        var tenantAdminUser = await GetTenantAdminUser(input.Id);
        if (tenantAdminUser == null)
            return new List<OwnMenuOutput>();
        var roleIds = await _sysUserRoleService.GetUserRoleIdList(tenantAdminUser.Id);
        var tenantAdminRoleId = roleIds[0]; // 租户管理员角色Id

        var menuList = await _sysRoleRep.Change<SysRoleMenu>().AsQueryable().LeftJoin<SysMenu>((t1, t2) => t1.SysMenuId == t2.Id)
            .Where(t1 => t1.SysRoleId == tenantAdminRoleId)
            .Select((t1, t2) => new SysMenu { Id = t1.SysMenuId, Application = t2.Application }).ToListAsync();

        // 拿出所有应用编码
        var appCodeList = menuList.Select(sl => sl.Application).Distinct().ToList();

        return appCodeList.Select(appCode => new OwnMenuOutput
        {
            AppCode = appCode,
            MenuIdList = menuList.FindAll(f => f.Application == appCode).Select(sl => sl.Id).ToList()
        }).ToList();
    }

    /// <summary>
    /// 重置租户管理员密码
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysTenant/resetPwd")]
    public async Task ResetUserPwd(QueryTenantInput input)
    {
        var tenantAdminUser = await GetTenantAdminUser(input.Id);
        tenantAdminUser.Password = MD5Encryption.Encrypt(await _sysConfigService.GetDefaultPassword());
        // 更新密码
        await _sysUserRep.AsUpdateable(tenantAdminUser)
            .Where(wh => wh.Id.Equals(tenantAdminUser.Id)).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取租户管理员用户
    /// </summary>
    /// <param name="tenantId"></param>
    /// <returns></returns>
    private async Task<SysUser> GetTenantAdminUser(long tenantId)
    {
        return await _sysUserRep.AsQueryable().Filter(null, true).FirstAsync(u => u.TenantId == tenantId && u.AdminType == AdminType.Admin);
    }

}
