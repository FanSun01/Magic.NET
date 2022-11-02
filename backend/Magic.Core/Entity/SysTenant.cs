using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 租户表
/// </summary>
[SugarTable("sys_tenant")]
[Description("租户表")]
public class SysTenant : DEntityBase
{
    /// <summary>
    /// 公司名称
    /// </summary>
    [Required, MaxLength(30)]
    [SugarColumn(ColumnDescription = "公司名称")]
    public string Name { get; set; }

    /// <summary>
    /// 管理员名称
    /// </summary>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "管理员名称")]
    public string AdminName { get; set; }

    /// <summary>
    /// 主机
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "主机", IsNullable = true)]
    public string Host { get; set; }

    /// <summary>
    /// 电子邮箱
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "电子邮箱", IsNullable = true)]
    public string Email { get; set; }

    /// <summary>
    /// 电话
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "电话", IsNullable = true)]
    public string Phone { get; set; }

    /// <summary>
    /// 数据库连接
    /// </summary>
    [MaxLength(200)]
    [SugarColumn(ColumnDescription = "数据库连接", IsNullable = true)]
    public string Connection { get; set; }

    /// <summary>
    /// 架构
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "架构", IsNullable = true)]
    public string Schema { get; set; }

    /// <summary>
    /// 备注
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }

    /// <summary>
    /// 租户类型
    /// </summary>
    [SugarColumn(ColumnDescription = "租户类型")]
    public TenantTypeEnum TenantType { get; set; }
}
