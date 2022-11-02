

using Furion.DependencyInjection;
using Magic.Core.Entity;
using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 员工附属机构和职位服务
/// </summary>
public class SysEmpExtOrgPosService : ISysEmpExtOrgPosService, ITransient
{
    private readonly SqlSugarRepository<SysEmpExtOrgPos> _sysEmpExtOrgPosRep;  // 附属机构表仓储 

    public SysEmpExtOrgPosService(SqlSugarRepository<SysEmpExtOrgPos> sysEmpExtOrgPosRep)
    {
        _sysEmpExtOrgPosRep = sysEmpExtOrgPosRep;
    }

    /// <summary>
    /// 保存或编辑附属机构相关信息
    /// </summary>
    /// <returns></returns>
    public async Task AddOrUpdate(long empId, List<EmpExtOrgPosOutput> extIdList)
    {
        try
        {
            _sysEmpExtOrgPosRep.CurrentBeginTran();
            // 先删除
            await DeleteEmpExtInfoByUserId(empId);

            if (extIdList != null && extIdList.Any())
            {
                var tasks = new List<SysEmpExtOrgPos>();
                extIdList.ForEach(u =>
                {
                    tasks.Add(new SysEmpExtOrgPos
                    {
                        SysEmpId = empId,
                        SysOrgId = u.OrgId,
                        SysPosId = u.PosId
                    });
                });
                await _sysEmpExtOrgPosRep.InsertAsync(tasks);
            }
            _sysEmpExtOrgPosRep.CurrentCommitTran();
        }
        catch (System.Exception)
        {
            _sysEmpExtOrgPosRep.CurrentRollbackTran();
            throw;
        }
       
    }

    /// <summary>
    /// 获取附属机构和职位信息
    /// </summary>
    /// <param name="empId"></param>
    /// <returns></returns>
    public async Task<List<EmpExtOrgPosOutput>> GetEmpExtOrgPosList(long empId)
    {
        return await _sysEmpExtOrgPosRep.AsQueryable().InnerJoin<SysPos>((e,p) => e.SysPosId == p.Id)
                                        .InnerJoin<SysOrg>((e, p, o)=> e.SysOrgId == o.Id)
										.Where((e, p, o) => e.SysEmpId == empId)
										.Select((e, p, o) => new EmpExtOrgPosOutput
										{
											SysEmpId = e.SysEmpId,
											OrgId = o.Id,
											OrgCode = o.Code,
											OrgName = o.Name,
											PosId = p.Id,
											PosCode = p.Code,
											PosName = p.Name
										}).ToListAsync();
	}

    public async Task<List<EmpExtOrgPosOutput>> GetEmpExtOrgPosList(List<long> empIds)
    {
		return await _sysEmpExtOrgPosRep.AsQueryable().InnerJoin<SysPos>((e, p) => e.SysPosId == p.Id)
										.InnerJoin<SysOrg>((e, p, o) => e.SysOrgId == o.Id)
										.Where((e, p, o) => empIds.Contains(e.SysEmpId))
                                        .Select((e, p, o) => new EmpExtOrgPosOutput
                                        {
                                            OrgId = o.Id,
                                            OrgCode = o.Code,
                                            OrgName = o.Name,
                                            PosId = p.Id,
                                            PosCode = p.Code,
                                            PosName = p.Name
                                        }).ToListAsync();
    }

    /// <summary>
    /// 根据机构Id判断该附属机构下是否有员工
    /// </summary>
    /// <param name="orgId"></param>
    /// <returns></returns>
    public async Task<bool> HasExtOrgEmp(long orgId)
    {
        return await _sysEmpExtOrgPosRep.AnyAsync(u => u.SysOrgId == orgId);
    }

    /// <summary>
    /// 根据职位Id判断该附属职位下是否有员工
    /// </summary>
    /// <param name="posId"></param>
    /// <returns></returns>
    public async Task<bool> HasExtPosEmp(long posId)
    {
        return await _sysEmpExtOrgPosRep.AnyAsync(u => u.SysPosId == posId);
    }

    /// <summary>
    /// 根据员工Id删除对应的员工-附属信息
    /// </summary>
    /// <param name="empId"></param>
    /// <returns></returns>
    public async Task DeleteEmpExtInfoByUserId(long empId)
    {
        await _sysEmpExtOrgPosRep.DeleteAsync(u => u.SysEmpId == empId);
    }
}
