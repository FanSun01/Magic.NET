

using Furion.DependencyInjection;
using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 用户数据范围服务
/// </summary>
public class SysUserDataScopeService : ISysUserDataScopeService, ITransient
{
    private readonly SqlSugarRepository<SysUserDataScope> _sysUserDataScopeRep;  // 用户数据范围表仓储 

    public SysUserDataScopeService(SqlSugarRepository<SysUserDataScope> sysUserDataScopeRep)
    {
        _sysUserDataScopeRep = sysUserDataScopeRep;
    }

    /// <summary>
    /// 授权用户数据
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    public async Task GrantData(UpdateUserInput input)
    {
        try
        {
            _sysUserDataScopeRep.CurrentBeginTran();
            await _sysUserDataScopeRep.DeleteAsync(u => u.SysUserId == input.Id);
            var grantOrgIdList = new List<SysUserDataScope>();
            input.GrantOrgIdList.ForEach(u =>
            {
                grantOrgIdList.Add(
                new SysUserDataScope
                {
                    SysUserId = input.Id,
                    SysOrgId = u
                });
            });
            await _sysUserDataScopeRep.InsertAsync(grantOrgIdList);
            _sysUserDataScopeRep.CurrentCommitTran();
        }
        catch (System.Exception)
        {
            _sysUserDataScopeRep.CurrentRollbackTran();
            throw;
        }

       
    }

    /// <summary>
    /// 获取用户的数据范围Id集合
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    public async Task<List<long>> GetUserDataScopeIdList(long userId)
    {
        return await _sysUserDataScopeRep
                                         .Where(u => u.SysUserId == userId)
                                         .Select(u => u.SysOrgId).ToListAsync();
    }

    /// <summary>
    /// 根据机构Id集合删除对应的用户-数据范围关联信息
    /// </summary>
    /// <param name="orgIdList"></param>
    /// <returns></returns>
    public async Task DeleteUserDataScopeListByOrgIdList(List<long> orgIdList)
    {
        await _sysUserDataScopeRep.DeleteAsync(u => orgIdList.Contains(u.SysOrgId));
    }

    /// <summary>
    /// 根据用户Id删除对应的用户-数据范围关联信息
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    public async Task DeleteUserDataScopeListByUserId(long userId)
    {
        await _sysUserDataScopeRep.DeleteAsync(u => u.SysUserId == userId);
    }
}
