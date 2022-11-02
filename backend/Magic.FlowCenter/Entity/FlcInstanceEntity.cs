using SqlSugar;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 自定义表单实体
/// </summary>
[Tenant("1")]
public class FlcInstanceEntity : PrimaryKeyEntity
{
	/// <summary>
	/// 申请流程Id
	/// </summary>
	[SugarColumn(IsNullable = true)]
	public long FlowInstanceId { get; set; }
}
