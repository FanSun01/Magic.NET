using Magic.Core;
using SqlSugar;
namespace Magic.FlowCenter.Entity;

/// <summary>
/// 流程
///</summary>
[SugarTable("flc_flowscheme")]
public class FlcFlowscheme : FlcDEntityBase
{
    /// <summary>
    ///  流程编号
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程编号",IsNullable = true)]
    public string SchemeCode { get; set; }
    /// <summary>
    ///  流程名称
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程名称", IsNullable = true)]
    public string SchemeName { get; set; }
    /// <summary>
    ///  流程类型
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程类型",IsNullable = true)]
    public string SchemeType { get; set; }
    /// <summary>
    ///  流程版本
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程版本",IsNullable = true)]
    public string SchemeVersion { get; set; }
    /// <summary>
    ///  流程使用人
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程使用人", IsNullable = true)]
    public string SchemeCanUser { get; set; }
    /// <summary>
    ///  流程内容
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "流程内容", ColumnDataType = "text", IsNullable = true)]
    public string SchemeContent { get; set; }
    /// <summary>
    ///  表单Id
    /// 默认值: 
    ///</summary>
    [SugarColumn( ColumnDescription = "表单Id", IsNullable = true)]
    public long? FrmId { get; set; }
    /// <summary>
    ///  表单类型
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "表单类型")]
    public FormType? FrmType { get; set; }
    /// <summary>
    ///  权限类型
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "权限类型")]
    public int? AuthorizeType { get; set; }
    /// <summary>
    ///  组织Id
    /// 默认值: 
    ///</summary>
    [SugarColumn( ColumnDescription = "组织Id",IsNullable = true)]
    public long? OrgId { get; set; }
    /// <summary>
    ///  
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "")]
    public string Active { get; set; }
    /// <summary>
    ///  状态
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "状态")]
    public CommonStatus? Status { get; set; }
    /// <summary>
    ///  排序
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "排序")]
    public int? Sort { get; set; }
    /// <summary>
    ///  备注
    /// 默认值: 
    ///</summary>
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }
}
