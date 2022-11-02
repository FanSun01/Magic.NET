﻿using System;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Service;

/// <summary>
/// 异常日志参数
/// </summary>
public class ExLogInput : PageInputBase
{
    /// <summary>
    /// 操作人
    /// </summary>
    public string Account { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public string Name { get; set; }

    /// <summary>
    /// 类名
    /// </summary>
    public string ClassName { get; set; }

    /// <summary>
    /// 方法名
    /// </summary>
    public string MethodName { get; set; }

    /// <summary>
    /// 异常名称
    /// </summary>
    public string ExceptionName { get; set; }

    /// <summary>
    /// 异常信息
    /// </summary>
    [MaxLength(2000)]
    public string ExceptionMsg { get; set; }

    /// <summary>
    /// 异常时间
    /// </summary>
    public DateTime ExceptionTime { get; set; }
}
