using System;
using System.Globalization;

namespace Magic.Core;

/// <summary>
/// DateTime扩展
/// </summary>
public static partial class Extensions
{
    /// <summary>
    /// 得到问好
    /// </summary>
    /// <returns></returns>
    public static string GetSayHello(this DateTime dateTime)
    {
        var hour = DateTime.Now.Hour;
        return hour switch
        {
            < 6 => "凌晨好！",
            < 9 => "早上好！",
            < 12 => "上午好！",
            < 14 => "中午好！",
            < 17 => "下午好！",
            < 19 => "傍晚好！",
            < 22 => "晚上好！",
            _ => "夜里好！"
        };
    }

    /// <summary>
    /// 获取指定年月的第一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <param name="year"></param>
    /// <param name="mon"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthFirstDay(this DateTime dateTime, string year, string mon)
    {
        var AssemblyDate = Convert.ToDateTime(year + "-" + mon + "-" + "01"); // 组装当前指定月份
        var result = AssemblyDate.AddDays(1 - AssemblyDate.Day); // 返回指定当前月份的第一天
        return new DateTime(result.Year, result.Month, result.Day, 0, 0, 0);
    }

    /// <summary>
    /// 获取指定年月的第一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <param name="year"></param>
    /// <param name="mon"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthFirstDay(this DateTime dateTime, int year, int mon)
    {
        var AssemblyDate = Convert.ToDateTime(year + "-" + mon + "-" + "01"); // 组装当前指定月份
        var result = AssemblyDate.AddDays(1 - AssemblyDate.Day); // 返回指定当前月份的第一天
        return new DateTime(result.Year, result.Month, result.Day, 0, 0, 0);
    }

    /// <summary>
    /// 获取指定年月的最后一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <param name="year"></param>
    /// <param name="mon"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthLastDay(this DateTime dateTime, string year, string mon)
    {
        var AssemblyDate = Convert.ToDateTime(year + "-" + mon + "-" + "01"); // 组装当前指定月份
        var result = AssemblyDate.AddDays(1 - AssemblyDate.Day).AddMonths(1).AddDays(-1); // 返回指定当前月份的最后一天
        return new DateTime(result.Year, result.Month, result.Day, 23, 59, 59);
    }

    /// <summary>
    /// 获取指定年月的最后一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <param name="year"></param>
    /// <param name="mon"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthLastDay(this DateTime dateTime, int year, int mon)
    {
        var AssemblyDate = Convert.ToDateTime(year + "-" + mon + "-" + "01"); // 组装当前指定月份
        var result = AssemblyDate.AddDays(1 - AssemblyDate.Day).AddMonths(1).AddDays(-1); // 返回指定当前月份的最后一天
        return new DateTime(result.Year, result.Month, result.Day, 23, 59, 59);
    }

    /// <summary>
    /// 获取当前月的第一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthFirstDay(this DateTime dateTime)
    {
        // 第一种写法
        //DateTime CurDate =Convert.ToDateTime(DateTime.Now.ToString());  // 组装当前指定月份
        //return CurDate.AddDays(1 - CurDate.Day);  // 返回指定当前月份的第一天

        // 第二种写法
        var nowDate = DateTime.Now;
        return new DateTime(nowDate.Year, nowDate.Month, 1, 0, 0, 0); // 该方法可以指定，年、月、日
    }

    /// <summary>
    /// 获取当前月的最后一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static DateTime GetCurMonthLastDay(this DateTime dateTime)
    {
        var CurDate = Convert.ToDateTime(DateTime.Now.ToString(CultureInfo.InvariantCulture)); // 组装当前指定月份
        var result = CurDate.AddDays(1 - CurDate.Day).AddMonths(1).AddDays(-1); // 返回指定当前月份的最后一天
        return new DateTime(result.Year, result.Month, result.Day, 23, 59, 59);
    }

    /// <summary>
    /// 获取上月的第一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static DateTime GetUpMonthFirstDay(this DateTime dateTime)
    {
        var nowDate = DateTime.Now.AddMonths(-1);
        return new DateTime(nowDate.Year, nowDate.Month, 1, 0, 0, 0); // 该方法可以指定，年、月、日
    }

    /// <summary>
    /// 获取上月的最后一天
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static DateTime GetUpMonthLastDay(this DateTime dateTime)
    {
        var CurDate = Convert.ToDateTime(DateTime.Now.ToString(CultureInfo.InvariantCulture)); // 组装当前指定月份
        var result = CurDate.AddDays(1 - CurDate.Day).AddDays(-1); // 返回指定上月份的最后一天
        return new DateTime(result.Year, result.Month, result.Day, 23, 59, 59);
    }

    /// <summary>
    /// 获取本周时间
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static (DateTime startTime, DateTime lastTime) GetCurWeekDay(this DateTime dateTime)
    {
        var startTime = DateTime.Now.AddDays(0 - Convert.ToInt16(DateTime.Now.DayOfWeek) + 1);
        var lastTime = DateTime.Now.AddDays(6 - Convert.ToInt16(DateTime.Now.DayOfWeek) + 1);
        return (new DateTime(startTime.Year, startTime.Month, startTime.Day, 0, 0, 0),
            new DateTime(lastTime.Year, lastTime.Month, lastTime.Day, 23, 59, 59));
    }

    /// <summary>
    /// 获取上周时间
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static (DateTime startTime, DateTime lastTime) GetUpWeekDay(this DateTime dateTime)
    {
        var startTime = DateTime.Now.AddDays(0 - Convert.ToInt16(DateTime.Now.DayOfWeek) - 6);
        var lastTime = DateTime.Now.AddDays(6 - Convert.ToInt16(DateTime.Now.DayOfWeek) - 6);
        return (new DateTime(startTime.Year, startTime.Month, startTime.Day, 0, 0, 0),
            new DateTime(lastTime.Year, lastTime.Month, lastTime.Day, 23, 59, 59));
    }

    /// <summary>
    /// 获取当天时间
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static (DateTime startTime, DateTime lastTime) GetCurDay(this DateTime dateTime)
    {
        var dt = DateTime.Now;
        return (new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0), new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59));
    }

    /// <summary>
    /// 获取昨天时间
    /// </summary>
    /// <param name="dateTime"></param>
    /// <returns></returns>
    public static (DateTime startTime, DateTime lastTime) GetUpDay(this DateTime dateTime)
    {
        var dt = DateTime.Now.AddDays(-1);
        return (new DateTime(dt.Year, dt.Month, dt.Day, 0, 0, 0), new DateTime(dt.Year, dt.Month, dt.Day, 23, 59, 59));
    }

    /// <summary>
    /// 计算两个时间的差
    /// </summary>
    /// <param name="dateTime"></param>
    /// <param name="startTime"></param>
    /// <param name="lastTime"></param>
    /// <returns></returns>
    public static int DateDiff(this DateTime dateTime, DateTime startTime, DateTime lastTime)
    {
        var start = Convert.ToDateTime(startTime.ToShortDateString());
        var end = Convert.ToDateTime(lastTime.ToShortDateString());
        var sp = end.Subtract(start);
        return sp.Days;
    }
}
