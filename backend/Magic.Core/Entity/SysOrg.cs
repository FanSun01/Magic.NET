using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 组织机构表
/// </summary>
[SugarTable("sys_org")]
[Description("组织机构表")]
public class SysOrg : DBEntityTenant
{
    /// <summary>
    /// 父Id
    /// </summary>
    [SugarColumn(ColumnDescription = "父Id")]
    public long Pid { get; set; }

    /// <summary>
    /// 父Ids
    /// </summary>
    [SugarColumn(ColumnDescription = "父Ids", IsNullable = true)]
    public string Pids { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    [Required, MaxLength(30)]
    [SugarColumn(ColumnDescription = "名称")]
    public string Name { get; set; }

    /// <summary>
    /// 编码
    /// </summary>
    [Required, MaxLength(50)]
    [SugarColumn(ColumnDescription = "编码")]
    public string Code { get; set; }

    /// <summary>
    /// 联系人
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "联系人", IsNullable = true)]
    public string Contacts { get; set; }

    /// <summary>
    /// 电话
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "电话", IsNullable = true)]
    public string Tel { get; set; }

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
