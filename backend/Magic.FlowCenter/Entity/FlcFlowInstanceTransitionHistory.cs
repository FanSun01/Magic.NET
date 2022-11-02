using System;
using SqlSugar;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 工作流实例流转历史记录
/// </summary>
[Tenant("1")]
[SugarTable("flc_flowinstancehis")]
public class FlcFlowInstanceTransitionHistory : PrimaryKeyEntity
{
    /// <summary>
    /// 实例Id
    /// </summary>
    [SugarColumn(IsNullable = false,ColumnDescription = "实例Id")]
    public long InstanceId { get; set; }
    /// <summary>
	    /// 开始节点Id
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "开始节点Id")]
    public string FromNodeId { get; set; }
    /// <summary>
	    /// 开始节点类型
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "开始节点类型")]
    public int? FromNodeType { get; set; }
    /// <summary>
	    /// 开始节点名称
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "开始节点名称")]
    public string FromNodeName { get; set; }
    /// <summary>
	    /// 结束节点Id
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "结束节点Id")]
    public string ToNodeId { get; set; }
    /// <summary>
	    /// 结束节点类型
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "结束节点类型")]
    public int? ToNodeType { get; set; }
    /// <summary>
	    /// 结束节点名称
	    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "结束节点名称")]
    public string ToNodeName { get; set; }
    /// <summary>
	    /// 转化状态
	    /// </summary>
    [SugarColumn(IsNullable = false, ColumnDescription = "转化状态")]
    public bool TransitionSate { get; set; }
    /// <summary>
	    /// 是否结束
	    /// </summary>
    [SugarColumn(IsNullable = false,ColumnDescription = "是否结束")]
    public bool IsFinish { get; set; }
    /// <summary>
	    /// 转化时间
	    /// </summary>
    [SugarColumn(IsNullable = false, ColumnDescription = "转化时间")]
    public DateTime CreatedTime { get; set; }
    /// <summary>
    /// 创建用户主键
    /// </summary>
    [SugarColumn(IsNullable = true, ColumnDescription = "创建用户主键")]
    public long CreatedUserId { get; set; }
    /// <summary>
    /// 创建用户
    /// </summary>
    [SugarColumn(IsNullable = true,ColumnDescription = "创建用户")]
    public string CreatedUserName { get; set; }

}
