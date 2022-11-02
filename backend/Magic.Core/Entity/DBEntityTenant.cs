
using SqlSugar;

namespace Magic.Core.Entity;

/// <summary>
/// 自定义租户基类实体
/// </summary>
public abstract class DBEntityTenant : DEntityBase
{
    /// <summary>
    /// 租户id
    /// </summary>
    [SugarColumn(ColumnDescription = "租户id", IsNullable = true)]
    public virtual long? TenantId { get; set; }

}
