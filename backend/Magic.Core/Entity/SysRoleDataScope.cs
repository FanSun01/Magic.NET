using SqlSugar;
using System.ComponentModel;

namespace Magic.Core.Entity;

/// <summary>
/// 角色数据范围表
/// </summary>
[SugarTable("sys_role_data_scope")]
[Description("角色数据范围表")]
public class SysRoleDataScope
{
    /// <summary>
    /// 角色Id
    /// </summary>
    [SugarColumn(ColumnDescription = "角色Id")]
    public long SysRoleId { get; set; }


    /// <summary>
    /// 机构Id
    /// </summary>
    [SugarColumn(ColumnDescription = "机构Id")]
    public long SysOrgId { get; set; }


}
