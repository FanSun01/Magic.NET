using Furion.TaskScheduler;
using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 定时任务
/// </summary>
[SugarTable("sys_timer")]
[Description("定时任务")]
public class SysTimer : DEntityBase
{
    /// <summary>
    /// 任务名称
    /// </summary>
    /// <example>magic</example>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "任务名称")]
    public string JobName { get; set; }

    /// <summary>
    /// 只执行一次
    /// </summary>
    [SugarColumn(ColumnDescription = "只执行一次")]
    public bool DoOnce { get; set; } = false;

    /// <summary>
    /// 立即执行（默认等待启动）
    /// </summary>
    [SugarColumn(ColumnDescription = "立即执行（默认等待启动）")]
    public bool StartNow { get; set; } = false;

    /// <summary>
    /// 执行类型(并行、列队)
    /// </summary>
    [SugarColumn(ColumnDescription = "执行类型(并行、列队)")]
    public SpareTimeExecuteTypes ExecuteType { get; set; } = SpareTimeExecuteTypes.Parallel;

    /// <summary>
    /// 执行间隔时间（单位秒）
    /// </summary>
    /// <example>5</example>
    [SugarColumn(ColumnDescription = "执行间隔时间（单位秒）", IsNullable = true)]
    public int? Interval { get; set; } = 5;

    /// <summary>
    /// Cron表达式
    /// </summary>
    /// <example></example>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "Cron表达式", IsNullable = true)]
    public string Cron { get; set; }

    /// <summary>
    /// 定时器类型
    /// </summary>
    [SugarColumn(ColumnDescription = "定时器类型")]
    public SpareTimeTypes TimerType { get; set; } = SpareTimeTypes.Interval;

    /// <summary>
    /// 请求url
    /// </summary>
    [MaxLength(200)]
    [SugarColumn(ColumnDescription = "请求url", IsNullable = true)]
    public string RequestUrl { get; set; }

    /// <summary>
    /// 请求参数（Post，Put请求用）
    /// </summary>
    [SugarColumn(ColumnDescription = "请求参数（Post，Put请求用）", IsNullable = true)]
    public string RequestParameters { get; set; }

    /// <summary>
    /// Headers(可以包含如：Authorization授权认证)
    /// 格式：{"Authorization":"userpassword.."}
    /// </summary>
    [SugarColumn(ColumnDescription = "Headers", IsNullable = true)]
    public string Headers { get; set; }

    /// <summary>
    /// 请求类型
    /// </summary>
    /// <example>2</example>
    [SugarColumn(ColumnDescription = "请求类型", IsNullable = true)]
    public RequestTypeEnum RequestType { get; set; } = RequestTypeEnum.Post;

    /// <summary>
    /// 备注
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }
}
