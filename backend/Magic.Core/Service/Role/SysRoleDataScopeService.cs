

using Furion.DependencyInjection;
using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 角色数据范围服务
/// </summary>
public class SysRoleDataScopeService : ISysRoleDataScopeService, ITransient
{
    private readonly SqlSugarRepository<SysRoleDataScope> _sysRoleDataScopeRep;  // 角色数据范围表仓储  
    private readonly SqlSugarRepository<SysRole> _roleRep;

		public SysRoleDataScopeService(SqlSugarRepository<SysRoleDataScope> sysRoleDataScopeRep, SqlSugarRepository<SysRole> roleRep)
    {
        _sysRoleDataScopeRep = sysRoleDataScopeRep;
        _roleRep = roleRep;
		}

    /// <summary>
    /// 授权角色数据范围
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public async Task GrantDataScope(GrantRoleDataInput input)
    {
        try
        {
            _sysRoleDataScopeRep.CurrentBeginTran();
            await _sysRoleDataScopeRep.DeleteAsync(u => u.SysRoleId == input.Id);

            var grantOrgIdList = new List<SysRoleDataScope>();
            input.GrantOrgIdList.ForEach(u =>
            {
                grantOrgIdList.Add(
                new SysRoleDataScope
                {
                    SysRoleId = input.Id,
                    SysOrgId = u
                });
            });
            await _roleRep.UpdateAsync(m => m.Id == input.Id,m => new SysRole() { DataScopeType = input.DataScopeType });
            await _sysRoleDataScopeRep.InsertAsync(grantOrgIdList);
            _sysRoleDataScopeRep.CurrentCommitTran();
        }
        catch (System.Exception)
        {
            _sysRoleDataScopeRep.CurrentRollbackTran();
            throw;
        }
       
    }

    /// <summary>
    /// 根据角色Id集合获取角色数据范围集合
    /// </summary>
    /// <param name="roleIdList"></param>
    /// <returns></returns>
    public async Task<List<long>> GetRoleDataScopeIdList(List<long> roleIdList)
    {
        return await _sysRoleDataScopeRep
                                         .Where(u => roleIdList.Contains(u.SysRoleId))
                                         .Select(u => u.SysOrgId).ToListAsync();
    }

    /// <summary>
    /// 根据机构Id集合删除对应的角色-数据范围关联信息
    /// </summary>
    /// <param name="orgIdList"></param>
    /// <returns></returns>
    public async Task DeleteRoleDataScopeListByOrgIdList(List<long> orgIdList)
    {
        await _sysRoleDataScopeRep.DeleteAsync(u => orgIdList.Contains(u.SysOrgId));
    }

    /// <summary>
    /// 根据角色Id删除对应的角色-数据范围关联信息
    /// </summary>
    /// <param name="roleId"></param>
    /// <returns></returns>
    public async Task DeleteRoleDataScopeListByRoleId(long roleId)
    {
        await _sysRoleDataScopeRep.DeleteAsync(u => u.SysRoleId == roleId);
    }
}
