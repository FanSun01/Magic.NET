using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Entity;

/// <summary>
/// 参数配置表
/// </summary>
[SugarTable("sys_config")]
[Description("参数配置表")]
public class SysConfig : DEntityBase
{
    /// <summary>
    /// 名称
    /// </summary>
    [Required, MaxLength(50)]
    [SugarColumn(ColumnDescription = "名称")]
    public string Name { get; set; }

    /// <summary>
    /// 编码
    /// </summary>
    [Required, MaxLength(50)]
    [SugarColumn(ColumnDescription = "编码", IsNullable = true)]
    public string Code { get; set; }

    /// <summary>
    /// 属性值
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "属性值", IsNullable = true)]
    public string Value { get; set; }

    /// <summary>
    /// 是否是系统参数（Y-是，N-否）
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否是系统参数（Y-是，N-否）", IsNullable = true)]
    public string SysFlag { get; set; }

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

    /// <summary>
    /// 常量所属分类的编码，来自于“常量的分类”字典
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "常量所属分类的编码，来自于“常量的分类”字典", IsNullable = true)]
    public string GroupCode { get; set; }

}
