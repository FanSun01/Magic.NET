using SqlSugar;
using System.ComponentModel;
namespace Magic.Core.Entity;

/// <summary>
/// 员工附属机构职位表
/// </summary>
[SugarTable("sys_emp_ext_org_pos")]
[Description("员工附属机构职位表")]
public class SysEmpExtOrgPos
{
    /// <summary>
    /// 员工Id
    /// </summary>
    [SugarColumn(ColumnDescription = "员工Id")]
    public long SysEmpId { get; set; }


    /// <summary>
    /// 机构Id
    /// </summary>
    [SugarColumn(ColumnDescription = "机构Id")]
    public long SysOrgId { get; set; }


    /// <summary>
    /// 职位Id
    /// </summary>
    [SugarColumn(ColumnDescription = "职位Id")]
    public long SysPosId { get; set; }
}
