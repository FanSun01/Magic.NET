using SqlSugar;
using System;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 自定义表单
/// </summary>
[SugarTable("flc_customform")]
public class FlcCustomForm : FlcInstanceEntity
{
    /// <summary>
    /// 名称
    /// </summary>
    [SugarColumn(ColumnDescription = "名称")]
    public string Name { get; set; }
    /// <summary>
    /// 排序
    /// </summary>
    [SugarColumn(ColumnDescription = "排序")]
    public int Sort { get; set; }
    /// <summary>
    /// 备注
    /// </summary>
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }
    /// <summary>
    /// 创建时间
    /// </summary>
    [SugarColumn(ColumnDescription = "创建时间")]
    public virtual DateTime? CreatedTime { get; set; }
    /// <summary>
    /// 创建者Id
    /// </summary>
    [SugarColumn(ColumnDescription = "创建者Id")]
    public virtual long? CreatedUserId { get; set; }
    /// <summary>
    /// 创建者名称
    /// </summary>
    [SugarColumn(ColumnDescription = "创建者名称")]
    public virtual string CreatedUserName { get; set; }
}
