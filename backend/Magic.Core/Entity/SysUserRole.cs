using SqlSugar;
using System.ComponentModel;

namespace Magic.Core.Entity;

/// <summary>
/// 用户角色表
/// </summary>
[SugarTable("sys_user_role")]
[Description("用户角色表")]
public class SysUserRole
{
    /// <summary>
    /// 用户Id
    /// </summary>
    [SugarColumn(ColumnDescription = "用户Id")]
    public long SysUserId { get; set; }



    /// <summary>
    /// 系统角色Id
    /// </summary>
    [SugarColumn(ColumnDescription = "系统角色Id")]
    public long SysRoleId { get; set; }


}
