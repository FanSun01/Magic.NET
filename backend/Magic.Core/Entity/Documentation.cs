using SqlSugar;
using System.Collections.Generic;
using System.ComponentModel;
namespace Magic.Core.Entity;

/// <summary>
/// 文档表
/// </summary>
[SugarTable("Documentation")]
[Description("文档表")]
public class Documentation : DEntityBase
{
    /// <summary>
    /// 父Id
    /// </summary>
    
    [SugarColumn(ColumnDescription = "父Id")]
    public long PId { get; set; }

    /// <summary>
    /// 父ID列表
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription= "父ID列表")]
    public string PIds { get; set; }
    /// <summary>
    /// 名称
    /// </summary>
    [SugarColumn(ColumnDescription= "名称")]
    public string Name { get; set; }
    /// <summary>
    /// 文档类型:文件、文件夹
    /// </summary>
    [SugarColumn(ColumnDescription = "文件类型")]
    public DocumentType DocumentType { get; set; }
    /// <summary>
    /// 文件后缀
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "文件后缀")]
    public string FileSuffix { get; set; }
    /// <summary>
    /// 文件大小kb
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "文件大小kb")]
    public int? FileSizeKb { get; set; }

    /// <summary>
    /// 文件路径
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "文件路径")]
    public string FilePath { get; set; }


    /// <summary>
    /// 存储后的文件名
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "存储后的文件名")]
    public string FileObjectName { get; set; }
    /// <summary>
    /// 标签
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "标签")]
    public int? Label { get; set; }
    /// <summary>
    /// 备注
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "备注")]
    public string Remark { get; set; }

    /// <summary>
    /// 是否可见
    /// </summary>
    [SugarColumn(IsNullable = true)]
    public bool Visible { get; set; } = true;

    [SugarColumn(IsIgnore = true)]
    public List<Documentation> Children { get; set; }

}
