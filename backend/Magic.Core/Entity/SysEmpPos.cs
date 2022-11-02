using SqlSugar;
using System.ComponentModel;

namespace Magic.Core.Entity;

/// <summary>
/// 员工职位表
/// </summary>
[SugarTable("sys_emp_pos")]
[Description("员工职位表")]
public class SysEmpPos
{
    /// <summary>
    /// 员工Id
    /// </summary>
    [SugarColumn(ColumnDescription = "员工Id")]
    public long SysEmpId { get; set; }



    /// <summary>
    /// 职位Id
    /// </summary>
    [SugarColumn(ColumnDescription = "职位Id")]
    public long SysPosId { get; set; }


}
