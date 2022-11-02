using SqlSugar;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Entity;

/// <summary>
/// 在线用户表
/// </summary>
[SugarTable("sys_online_user")]
[Description("在线用户表")]
public class OnlineUser : AutoIncrementEntity
{
    /// <summary>
    /// 连接Id
    /// </summary>
    [SugarColumn(ColumnDescription = "连接Id")]
    public string ConnectionId { get; set; }

    /// <summary>
    /// 用户Id
    /// </summary>
    [SugarColumn(ColumnDescription = "用户Id")]
    public long UserId { get; set; }

    /// <summary>
    /// 账号
    /// </summary>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "账号", IsNullable = true)]
    public string Account { get; set; }

    /// <summary>
    /// 姓名
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "姓名", IsNullable = true)]
    public string Name { get; set; }

    /// <summary>
    /// 最后连接时间
    /// </summary>
    [SugarColumn(ColumnDescription = "最后连接时间", IsNullable = true)]
    public DateTime LastTime { get; set; }

    /// <summary>
    /// 最后登录IP
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "最后登录IP", IsNullable = true)]
    public string LastLoginIp { get; set; }

    /// <summary>
    /// 租户id
    /// </summary>
    [SugarColumn(ColumnDescription = "租户id", IsNullable = true)]
    public virtual long TenantId { get; set; }

}
