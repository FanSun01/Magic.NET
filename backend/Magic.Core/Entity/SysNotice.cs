using SqlSugar;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 通知公告表
/// </summary>
[SugarTable("sys_notice")]
[Description("通知公告表")]
public class SysNotice : DEntityBase
{
    /// <summary>
    /// 标题
    /// </summary>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "标题")]
    public string Title { get; set; }

    /// <summary>
    /// 内容
    /// </summary>
    [Required]
    [SugarColumn(ColumnDescription = "内容")]
    public string Content { get; set; }

    /// <summary>
    /// 类型（字典 1通知 2公告）
    /// </summary>
    [SugarColumn(ColumnDescription = "类型（字典 1通知 2公告）")]
    public NoticeType Type { get; set; }

    /// <summary>
    /// 发布人Id
    /// </summary>
    [SugarColumn(ColumnDescription = "发布人Id")]
    public long PublicUserId { get; set; }

    /// <summary>
    /// 发布人姓名
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "发布人姓名", IsNullable = true)]
    public string PublicUserName { get; set; }

    /// <summary>
    /// 发布机构Id
    /// </summary>
    [SugarColumn(ColumnDescription = "发布机构Id")]
    public long PublicOrgId { get; set; }

    /// <summary>
    /// 发布机构名称
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "发布机构名称", IsNullable = true)]
    public string PublicOrgName { get; set; }

    /// <summary>
    /// 发布时间
    /// </summary>
    [SugarColumn(ColumnDescription = "发布时间")]
    public DateTime PublicTime { get; set; }

    /// <summary>
    /// 撤回时间
    /// </summary>
    [SugarColumn(ColumnDescription = "撤回时间", IsNullable = true)]
    public DateTime CancelTime { get; set; }

    /// <summary>
    /// 状态（字典 0草稿 1发布 2撤回 3删除）
    /// </summary>
    [SugarColumn(ColumnDescription = "状态（字典 0草稿 1发布 2撤回 3删除）")]
    public NoticeStatus Status { get; set; }
}
