using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 职位表
/// </summary>
[SugarTable("sys_pos")]
[Description("职位表")]
public class SysPos : DBEntityTenant
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
    /// 排序
    /// </summary>
    [SugarColumn(ColumnDescription = "排序")]
    public int Sort { get; set; }

    /// <summary>
    /// 备注
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }

    /// <summary>
    /// 状态（字典 0正常 1停用 2删除）
    /// </summary>
    [SugarColumn(ColumnDescription = "状态（字典 0正常 1停用 2删除）")]
    public CommonStatus Status { get; set; } = CommonStatus.ENABLE;

}
