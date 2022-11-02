

using Furion.DependencyInjection;
using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 用户角色服务
/// </summary>
public class SysUserRoleService : ISysUserRoleService, ITransient
{
    private readonly SqlSugarRepository<SysUserRole> _sysUserRoleRep;  // 用户权限表仓储 

    private readonly ISysRoleService _sysRoleService;
    private readonly ISysCacheService _sysCacheService;

    public SysUserRoleService(SqlSugarRepository<SysUserRole> sysUserRoleRep, ISysRoleService sysRoleService,ISysCacheService sysCacheService)
    {
        _sysUserRoleRep = sysUserRoleRep;
        _sysRoleService = sysRoleService;
        _sysCacheService = sysCacheService;
    }

    /// <summary>
    /// 获取用户的角色Id集合
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    public async Task<List<long>> GetUserRoleIdList(long userId)
    {
        return await _sysUserRoleRep.Where(u => u.SysUserId == userId).Select(u => u.SysRoleId).ToListAsync();
    }

    /// <summary>
    /// 授权用户角色
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public async Task GrantRole(UpdateUserInput input)
    {
        try
        {
            _sysUserRoleRep.CurrentBeginTran();
            await _sysUserRoleRep.DeleteAsync(u => u.SysUserId == input.Id);
            var grantRoleIdList = new List<SysUserRole>();
            input.GrantRoleIdList.ForEach(u =>
            {
                grantRoleIdList.Add(
                new SysUserRole
                {
                    SysUserId = input.Id,
                    SysRoleId = u
                });
            });
            await _sysUserRoleRep.InsertAsync(grantRoleIdList);
            _sysUserRoleRep.CurrentCommitTran();
            //清除缓存
			await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_MENU);
			await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_PERMISSION);
        }
        catch (System.Exception)
        {
            _sysUserRoleRep.CurrentRollbackTran();
            throw;
        }
       
    }

    /// <summary>
    /// 获取用户所有角色的数据范围（组织机构Id集合）
    /// </summary>
    /// <param name="userId"></param>
    /// <param name="orgId"></param>
    /// <returns></returns>
    public async Task<List<long>> GetUserRoleDataScopeIdList(long userId, long orgId)
    {
        var roleIdList = await GetUserRoleIdList(userId);

        // 获取这些角色对应的数据范围
        if (roleIdList.Count > 0)
            return await _sysRoleService.GetUserDataScopeIdList(roleIdList, orgId);

        return roleIdList;
    }

    /// <summary>
    /// 根据角色Id删除对应的用户-角色表关联信息
    /// </summary>
    /// <param name="roleId"></param>
    /// <returns></returns>
    public async Task DeleteUserRoleListByRoleId(long roleId)
    {
        await _sysUserRoleRep.DeleteAsync(u => u.SysRoleId == roleId);
    }

    /// <summary>
    /// 根据用户Id删除对应的用户-角色表关联信息
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    public async Task DeleteUserRoleListByUserId(long userId)
    {
        await _sysUserRoleRep.DeleteAsync(u => u.SysUserId == userId);
    }
}
