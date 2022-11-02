using SqlSugar;
using System;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 工作流实例操作记录
/// </summary>
[Tenant("1")]
[SugarTable("flc_flowinstanceinfo")]
public class FlcFlowInstanceOperationHistory : PrimaryKeyEntity
{
    /// <summary>
    /// 实例进程Id
    /// </summary>
    [SugarColumn(IsNullable = false,ColumnDescription = "实例进程Id")]
    public long InstanceId { get; set; }
    /// <summary>
	    /// 操作内容
	    /// </summary>
    [SugarColumn(IsNullable = true,ColumnDescription = "操作内容")]
    public string Content { get; set; }
    /// <summary>
	    /// 创建时间
	    /// </summary>
    [SugarColumn(IsNullable = false,ColumnDescription = "类别名称")]
    public DateTime? CreatedTime { get; set; }
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
