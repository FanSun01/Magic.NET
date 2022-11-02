

using Furion.DependencyInjection;
using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 角色菜单
/// </summary>
public class SysRoleMenuService : ISysRoleMenuService, ITransient
{
    private readonly SqlSugarRepository<SysRoleMenu> _sysRoleMenuRep;  // 角色菜单表仓储   
    private readonly ISysCacheService _sysCacheService;
    private readonly SqlSugarRepository<SysRole> _sysRoleRep;

    public SysRoleMenuService(SqlSugarRepository<SysRoleMenu> sysRoleMenuRep, ISysCacheService sysCacheService, SqlSugarRepository<SysRole> sysRoleRep)
    {
        _sysRoleMenuRep = sysRoleMenuRep;
        _sysCacheService = sysCacheService;
        _sysRoleRep = sysRoleRep;
    }

    /// <summary>
    /// 获取角色的菜单Id集合
    /// </summary>
    /// <param name="roleIdList"></param>
    /// <returns></returns>
    public async Task<List<long>> GetRoleMenuIdList(List<long> roleIdList)
    {
        return await _sysRoleMenuRep
                                    .Where(u => roleIdList.Contains(u.SysRoleId))
                                    .Select(u => u.SysMenuId).ToListAsync();
    }

    /// <summary>
    /// 授权角色菜单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public async Task GrantMenu(GrantRoleMenuInput input)
    {
        try
        {
            _sysRoleMenuRep.CurrentBeginTran();
            await _sysRoleMenuRep.DeleteAsync(u => u.SysRoleId == input.Id);

            var grantMenuIdList = new List<SysRoleMenu>();

            input.GrantMenuIdList.ForEach(u =>
            {
                grantMenuIdList.Add(
                new SysRoleMenu
                {
                    SysRoleId = input.Id,
                    SysMenuId = u
                });
            });
            await _sysRoleMenuRep.InsertAsync(grantMenuIdList);
            _sysRoleMenuRep.CurrentCommitTran();
        }
        catch (System.Exception)
        {
            _sysRoleMenuRep.CurrentRollbackTran();
            throw;
        }
        // 清除缓存
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_MENU);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_PERMISSION);
    }

    /// <summary>
    /// 根据菜单Id集合删除对应的角色-菜单表信息
    /// </summary>
    /// <param name="menuIdList"></param>
    /// <returns></returns>
    public async Task DeleteRoleMenuListByMenuIdList(List<long> menuIdList)
    {
        await _sysRoleMenuRep.DeleteAsync(u => menuIdList.Contains(u.SysMenuId));
    }

    /// <summary>
    /// 根据角色Id删除对应的角色-菜单表关联信息
    /// </summary>
    /// <param name="roleId"></param>
    /// <returns></returns>
    public async Task DeleteRoleMenuListByRoleId(long roleId)
    {
        await _sysRoleMenuRep.DeleteAsync(u => u.SysRoleId == roleId);
    }

    /// <summary>
    /// 清理租户下角色的权限
    /// </summary>
    /// <param name="tenantId">租户id</param>
    /// <param name="manageRoleId">租户管理员的角色id</param>
    /// <returns></returns>
    public async Task ClearRoleMenuListByTenantId(long tenantId, long manageRoleId)
    {
        List<long> roleIds = await _sysRoleRep.Where(m => m.TenantId == tenantId).Select(m => m.Id).ToListAsync();
        roleIds.Remove(manageRoleId);
        var managePermissionList = await _sysRoleMenuRep.Where(m => m.SysRoleId == manageRoleId).Select(m => m.SysMenuId).ToListAsync();

        await _sysRoleMenuRep.DeleteAsync(m => roleIds.Contains(m.SysRoleId) && !managePermissionList.Contains(m.SysMenuId));
    }
}
