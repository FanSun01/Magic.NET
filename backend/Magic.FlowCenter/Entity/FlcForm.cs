using Magic.Core;
using SqlSugar;
namespace Magic.FlowCenter.Entity;

/// <summary>
/// 表单
///</summary>
[SugarTable("flc_form")]
public class FlcForm: FlcDEntityBase
{
    /// <summary>
    ///  表单名称
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "表单名称", IsNullable = true)]
     public string Name { get; set; }
    /// <summary>
    ///  表单类型
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "表单类型", IsNullable = true)]
    public FormType? FrmType { get; set; }
    /// <summary>
    ///  自定义表单
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "自定义表单", IsNullable = true)]
     public string WebId { get; set; }
    /// <summary>
    ///  字段数
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "字段数",IsNullable = true)]
     public int? Fields { get; set; }
    /// <summary>
    ///  字段
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "字段", ColumnDataType = "text", IsNullable = true)]
     public string ContentData { get; set; }
    /// <summary>
    ///  字段格式化
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "字段格式化", ColumnDataType = "text", IsNullable = true)]
     public string ContentParse { get; set; }
    /// <summary>
    ///  表单内容
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "表单内容", ColumnDataType = "text", IsNullable = true)]
     public string Content { get; set; }
    /// <summary>
    ///  数据库备用
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "数据库备用",IsNullable = true)]
     public string DbName { get; set; }
    /// <summary>
    ///  组织id
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "组织id", IsNullable = true)]
     public long? OrgId { get; set; }
    /// <summary>
    ///  
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnName="Active",ColumnDescription="",IsNullable = true)]
     public string Active { get; set; }
    /// <summary>
    ///  状态
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription= "状态")]
    public CommonStatus? Status { get; set; }
    /// <summary>
    ///  排序
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription= "排序")]
     public int? Sort { get; set; }
    /// <summary>
    ///  备注
    /// 默认值: 
    ///</summary>
     [SugarColumn(ColumnDescription= "备注", IsNullable = true)]
     public string Remark { get; set; }
}
