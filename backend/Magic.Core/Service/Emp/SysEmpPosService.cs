

using Furion.DependencyInjection;
using Magic.Core.Entity;
using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 员工职位服务
/// </summary>
public class SysEmpPosService : ISysEmpPosService, ITransient
{
    private readonly SqlSugarRepository<SysEmpPos> _sysEmpPosRep;  // 员工职位表仓储    

    public SysEmpPosService(SqlSugarRepository<SysEmpPos> sysEmpPosRep)
    {
        _sysEmpPosRep = sysEmpPosRep;
    }

    /// <summary>
    /// 增加或编辑员工职位相关信息
    /// </summary>
    /// <param name="empId">员工Id（用户Id）</param>
    /// <param name="posIdList">职位id集合</param>
    /// <returns></returns>
    public async Task AddOrUpdate(long empId, List<long> posIdList)
    {
        try
        {
            _sysEmpPosRep.CurrentBeginTran();
            // 先删除
            await DeleteEmpPosInfoByUserId(empId);

            if (posIdList != null && posIdList.Any())
            {
                List<SysEmpPos> list = new List<SysEmpPos>();
                posIdList.ForEach(u =>
                {
                    list.Add(new SysEmpPos
                    {
                        SysEmpId = empId,
                        SysPosId = u
                    });
                });
                await _sysEmpPosRep.InsertAsync(list);
            }
            _sysEmpPosRep.CurrentCommitTran();
        }
        catch (System.Exception)
        {
            _sysEmpPosRep.CurrentRollbackTran();
            throw;
        }
       
    }

    /// <summary>
    /// 获取所属职位信息
    /// </summary>
    /// <param name="empId">员工Id（用户Id）</param>
    public async Task<List<EmpPosOutput>> GetEmpPosList(long empId)
    {
        return await _sysEmpPosRep.AsQueryable().InnerJoin<SysPos>((e, p) => e.SysPosId == p.Id)
                                   .Where((e, p) => e.SysEmpId == empId)
                                   .Select((e, p) => new EmpPosOutput
                                   {
                                       PosId = p.Id,
                                       PosCode = p.Code,
                                       PosName = p.Name
                                   }).ToListAsync();
    }

    public async Task<List<EmpPosOutput>> GetEmpPosList(List<long> empIds)
    {
		return await _sysEmpPosRep.AsQueryable().InnerJoin<SysPos>((e, p) => e.SysPosId == p.Id)
								   .Where((e, p) => empIds.Contains(e.SysEmpId))
                                   .Select((e, p) => new EmpPosOutput
                                   {
                                       PosId = p.Id,
                                       PosCode = p.Code,
                                       PosName = p.Name
                                   }).ToListAsync();
    }

    /// <summary>
    /// 根据职位Id判断该职位下是否有员工
    /// </summary>
    /// <param name="posId"></param>
    /// <returns></returns>
    public async Task<bool> HasPosEmp(long posId)
    {
        return await _sysEmpPosRep.AnyAsync(u => u.SysPosId == posId);
    }

    /// <summary>
    /// 根据员工Id删除对用的员工-职位信息
    /// </summary>
    /// <param name="empId"></param>
    /// <returns></returns>
    public async Task DeleteEmpPosInfoByUserId(long empId)
    {
        await _sysEmpPosRep.DeleteAsync(u => u.SysEmpId == empId);
    }
}
