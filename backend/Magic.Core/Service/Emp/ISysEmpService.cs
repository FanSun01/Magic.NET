using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysEmpService
{
    Task AddOrUpdate(EmpOutput2 sysEmpParam);
    Task DeleteEmpInfoByUserId(long empId);
    Task<EmpOutput> GetEmpInfo(long empId);
    Task<List<EmpOutput>> GetEmpInfo(List<long> empIds);
    Task<long> GetEmpOrgId(long empId);
    Task<bool> HasOrgEmp(long orgId);
    Task UpdateEmpOrgInfo(long orgId, string orgName);
    Task<List<SysEmp>> HasOrgEmp(List<long> orgIds);
}
