﻿
using SqlSugar;
using System;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 系统操作/审计日志表
/// </summary>
[SugarTable("sys_log_audit")]
[Description("系统操作/审计日志表")]
public class SysLogAudit : AutoIncrementEntity
{
    /// <summary>
    /// 表名
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "表名", IsNullable = true)]
    public string TableName { get; set; }

    /// <summary>
    /// 列名
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "列名", IsNullable = true)]
    public string ColumnName { get; set; }

    /// <summary>
    /// 新值
    /// </summary>
    [SugarColumn(ColumnDescription = "新值", IsNullable = true)]
    public string NewValue { get; set; }

    /// <summary>
    /// 旧值
    /// </summary>
    [SugarColumn(ColumnDescription = "旧值", IsNullable = true)]
    public string OldValue { get; set; }

    /// <summary>
    /// 操作时间
    /// </summary>
    [SugarColumn(ColumnDescription = "操作时间", IsNullable = true)]
    public DateTime CreatedTime { get; set; }

    /// <summary>
    /// 操作人Id
    /// </summary>
    [SugarColumn(ColumnDescription = "操作人Id")]
    public long UserId { get; set; }

    /// <summary>
    /// 操作人名称
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "操作人名称", IsNullable = true)]
    public string UserName { get; set; }

    /// <summary>
    /// 操作方式：新增、更新、删除
    /// </summary>

    [SugarColumn(ColumnDescription = "操作方式：新增、更新、删除")]
    public DataOpType Operate { get; set; }
}
