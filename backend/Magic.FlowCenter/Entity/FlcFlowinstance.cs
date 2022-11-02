using System.ComponentModel.DataAnnotations;
using Magic.Core;
using SqlSugar;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 创 建：超级管理员
/// 日 期：2020-07-14 09:18
/// 描 述：我的流程实体类
/// </summary>
[SugarTable("flc_flowinstance")]
public class FlcFlowinstance: FlcDBEntityTenant
{
    /// <summary>
    /// 流程实例模板Id
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "流程实例模板Id")]
    public long? InstanceSchemeId { get; set; }
    /// <summary>
    /// 实例编号
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = false,ColumnDescription = "实例编号", UniqueGroupNameList = new string[] { "oms_flowinstance" })]
    public string Code { get; set; }
    /// <summary>
    /// 自定义名称
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "自定义名称")]
    public string CustomName { get; set; }
    /// <summary>
    /// 当前节点ID
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "当前节点ID")]
    public string ActivityId { get; set; }
    /// <summary>
    /// 当前节点类型（0会签节点）
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "当前节点类型")]
    public int? ActivityType { get; set; }
    /// <summary>
    /// 当前节点名称
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "当前节点名称")]
    public string ActivityName { get; set; }
    /// <summary>
    /// 前一个ID
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true,ColumnDescription = "前一个ID")]
    public string PreviousId { get; set; }
    /// <summary>
    /// 流程模板内容
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDataType = "text", ColumnDescription = "流程模板内容")]
    public string SchemeContent { get; set; }
    /// <summary>
    /// 流程模板ID
    /// </summary>
    /// <returns></returns>
    [Required(ErrorMessage = "模板不能为空")]
    [SugarColumn(IsNullable = true,ColumnDescription = "流程模板ID")]
    public long SchemeId { get; set; }
    /// <summary>
    /// 数据库名称
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = false, ColumnDescription = "数据库名称")]
    public string DbName { get; set; }
    /// <summary>
    /// 表单数据
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnName = "FrmData", ColumnDataType = "text", ColumnDescription = "表单数据")]
    public string FrmData { get; set; }
    /// <summary>
    /// 表单类型
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = false, ColumnDescription = "表单类型")] 
    public FormType? FrmType { get; set; }
    /// <summary>
    /// 表单中的字段
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDataType = "text", ColumnDescription = "表单中的字段")]
    public string FrmContentData { get; set; }
    /// <summary>
    /// 表单字段（冗余)
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDataType = "text", ColumnDescription = "表单字段")]
    public string FrmContentParse { get; set; }
    /// <summary>
    /// 表单参数
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true,ColumnDataType = "text", ColumnDescription = "表单参数")]
    public string FrmContent { get; set; }
    /// <summary>
    /// 表单ID
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDescription = "表单ID")]
    public long? FrmId { get; set; }
    /// <summary>
    /// 流程类型
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDataType = "text", ColumnDescription = "流程类型")]
    public string SchemeType { get; set; }
    /// <summary>
    /// 等级
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = false, ColumnDescription = "等级")]
    public int FlowLevel { get; set; }
    /// <summary>
    /// 是否完成
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = false, ColumnDescription = "是否完成")]
    public int IsFinish { get; set; }
    /// <summary>
    /// 执行人
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true, ColumnDataType = "text", ColumnDescription = "执行人")]
    public string MakerList { get; set; }
    /// <summary>
    /// 所属部门
    /// </summary>
    /// <returns></returns>
    [SugarColumn(IsNullable = true,  ColumnDescription = "所属部门")]
    public long? OrgId { get; set; }
    /// <summary>
    ///  状态标识
    ///</summary>
    [SugarColumn(ColumnDescription = "状态")]
    public CommonStatus? Status { get; set; }
    /// <summary>
    /// 如果下个执行节点是运行时指定执行者。需要传指定的类型
    /// <para>取值为RUNTIME_SPECIAL_ROLE、RUNTIME_SPECIAL_USER</para>
    /// </summary>
    [SugarColumn(IsIgnore=true)]
    public string NextNodeDesignateType { get; set; }

    /// <summary>
    /// 如果下个执行节点是运行时指定执行者。该值表示具体的执行者
    /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_ROLE，则该值为指定的角色</para>
    /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_USER，则该值为指定的用户</para>
    /// </summary>
    [SugarColumn(IsIgnore=true)]
    public string[] NextNodeDesignates { get; set; }
    /// <summary>
    /// 下个节点执行人
    /// </summary>
    [SugarColumn(IsIgnore=true)]
    public string NextMakerName { get; set; }
    /// <summary>
    /// 当前节点执行人
    /// </summary>
    [SugarColumn(IsIgnore=true)]
    public string CurrentMakerName { get; set; }
    /// <summary>
    /// 当前节点执行类型
    /// </summary>
    [SugarColumn(IsIgnore=true)]
    public string CurrentNodeDesignateType { get; set; }
}
