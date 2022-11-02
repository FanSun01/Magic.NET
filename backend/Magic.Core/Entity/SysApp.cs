using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Entity;

/// <summary>
/// 系统应用表
/// </summary>
[SugarTable("sys_app", TableDescription = "系统应用表")]
[Description("系统应用表")]
public class SysApp : DEntityBase
{
    /// <summary>
    /// 名称
    /// </summary>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "名称")]
    public string Name { get; set; }

    /// <summary>
    /// 编码
    /// </summary>
    [Required, MaxLength(50)]
    [SugarColumn(ColumnDescription = "编码")]
    public string Code { get; set; }

    /// <summary>
    /// 是否默认激活（Y-是，N-否）,只能有一个系统默认激活
    /// 用户登录后默认展示此系统菜单
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否默认激活")]
    public string Active { get; set; }

    /// <summary>
    /// 状态（字典 0正常 1停用 2删除）
    /// </summary>
    [SugarColumn(ColumnDescription = "状态")]
    public CommonStatus Status { get; set; } = CommonStatus.ENABLE;

    /// <summary>
    /// 排序
    /// </summary>
    [SugarColumn(ColumnDescription = "排序")]
    public int Sort { get; set; }
}
