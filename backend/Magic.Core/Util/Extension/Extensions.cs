using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.Linq;

namespace Magic.Core;

/// <summary>
/// 转换扩展类
/// </summary>
public static partial class Extensions
{
    #region 转换为long

    /// <summary>
    /// 将object转换为long，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static long ParseToLong(this object obj)
    {
        try
        {
            return long.Parse(obj.ToString() ?? string.Empty);
        }
        catch
        {
            return 0L;
        }
    }

    /// <summary>
    /// 将object转换为long，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static long ParseToLong(this string str, long defaultValue)
    {
        try
        {
            return long.Parse(str);
        }
        catch
        {
            return defaultValue;
        }
    }

    #endregion

    #region 转换为int

    /// <summary>
    /// 将object转换为int，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static int ParseToInt(this object str)
    {
        try
        {
            return Convert.ToInt32(str);
        }
        catch
        {
            return 0;
        }
    }

    /// <summary>
    /// 将object转换为int，若转换失败，则返回指定值。不抛出异常。 
    /// null返回默认值
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static int ParseToInt(this object str, int defaultValue)
    {
        if (str == null)
        {
            return defaultValue;
        }

        try
        {
            return Convert.ToInt32(str);
        }
        catch
        {
            return defaultValue;
        }
    }

    #endregion

    #region 转换为short

    /// <summary>
    /// 将object转换为short，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static short ParseToShort(this object obj)
    {
        try
        {
            return short.Parse(obj.ToString() ?? string.Empty);
        }
        catch
        {
            return 0;
        }
    }

    /// <summary>
    /// 将object转换为short，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static short ParseToShort(this object str, short defaultValue)
    {
        try
        {
            return short.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return defaultValue;
        }
    }

    #endregion

    #region 转换为demical

    /// <summary>
    /// 将object转换为demical，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static decimal ParseToDecimal(this object str, decimal defaultValue)
    {
        try
        {
            return decimal.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return defaultValue;
        }
    }

    /// <summary>
    /// 将object转换为demical，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static decimal ParseToDecimal(this object str)
    {
        try
        {
            return decimal.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return 0;
        }
    }

    #endregion

    #region 转化为bool

    /// <summary>
    /// 将object转换为bool，若转换失败，则返回false。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static bool ParseToBool(this object str)
    {
        try
        {
            return bool.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return false;
        }
    }

    /// <summary>
    /// 将object转换为bool，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="result"></param>
    /// <returns></returns>
    public static bool ParseToBool(this object str, bool result)
    {
        try
        {
            return bool.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return result;
        }
    }

    #endregion

    #region 转换为float

    /// <summary>
    /// 将object转换为float，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static float ParseToFloat(this object str)
    {
        try
        {
            return float.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return 0;
        }
    }

    /// <summary>
    /// 将object转换为float，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="result"></param>
    /// <returns></returns>
    public static float ParseToFloat(this object str, float result)
    {
        try
        {
            return float.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return result;
        }
    }

    #endregion

    #region 转换为Guid

    /// <summary>
    /// 将string转换为Guid，若转换失败，则返回Guid.Empty。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static Guid ParseToGuid(this string str)
    {
        try
        {
            return new Guid(str);
        }
        catch
        {
            return Guid.Empty;
        }
    }

    #endregion

    #region 转换为DateTime

    /// <summary>
    /// 将string转换为DateTime，若转换失败，则返回日期最小值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <returns></returns>
    public static DateTime ParseToDateTime(this string str)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(str))
            {
                return DateTime.MinValue;
            }

            if (str.Contains("-") || str.Contains("/"))
            {
                return DateTime.Parse(str);
            }

            var length = str.Length;
            return length switch
            {
                4 => DateTime.ParseExact(str, "yyyy", CultureInfo.CurrentCulture),
                6 => DateTime.ParseExact(str, "yyyyMM", CultureInfo.CurrentCulture),
                8 => DateTime.ParseExact(str, "yyyyMMdd", CultureInfo.CurrentCulture),
                10 => DateTime.ParseExact(str, "yyyyMMddHH", CultureInfo.CurrentCulture),
                12 => DateTime.ParseExact(str, "yyyyMMddHHmm", CultureInfo.CurrentCulture),
                // ReSharper disable once StringLiteralTypo
                14 => DateTime.ParseExact(str, "yyyyMMddHHmmss", CultureInfo.CurrentCulture),
                // ReSharper disable once StringLiteralTypo
                _ => DateTime.ParseExact(str, "yyyyMMddHHmmss", CultureInfo.CurrentCulture)
            };
        }
        catch
        {
            return DateTime.MinValue;
        }
    }

    /// <summary>
    /// 将string转换为DateTime，若转换失败，则返回默认值。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static DateTime ParseToDateTime(this string str, DateTime? defaultValue)
    {
        try
        {
            if (string.IsNullOrWhiteSpace(str))
            {
                return defaultValue.GetValueOrDefault();
            }

            if (str.Contains("-") || str.Contains("/"))
            {
                return DateTime.Parse(str);
            }

            var length = str.Length;
            return length switch
            {
                4 => DateTime.ParseExact(str, "yyyy", CultureInfo.CurrentCulture),
                6 => DateTime.ParseExact(str, "yyyyMM", CultureInfo.CurrentCulture),
                8 => DateTime.ParseExact(str, "yyyyMMdd", CultureInfo.CurrentCulture),
                10 => DateTime.ParseExact(str, "yyyyMMddHH", CultureInfo.CurrentCulture),
                12 => DateTime.ParseExact(str, "yyyyMMddHHmm", CultureInfo.CurrentCulture),
                // ReSharper disable once StringLiteralTypo
                14 => DateTime.ParseExact(str, "yyyyMMddHHmmss", CultureInfo.CurrentCulture),
                // ReSharper disable once StringLiteralTypo
                _ => DateTime.ParseExact(str, "yyyyMMddHHmmss", CultureInfo.CurrentCulture)
            };
        }
        catch
        {
            return defaultValue.GetValueOrDefault();
        }
    }

    #endregion

    #region 转换为string

    /// <summary>
    /// 将object转换为string，若转换失败，则返回""。不抛出异常。  
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static string ParseToString(this object obj)
    {
        try
        {
            return obj == null ? string.Empty : obj.ToString();
        }
        catch
        {
            return string.Empty;
        }
    }

    /// <summary>
    /// 
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static string ParseToStrings<T>(this object obj)
    {
        try
        {
            if (obj is IEnumerable<T> list)
            {
                return string.Join(",", list);
            }

            return obj.ToString();
        }
        catch
        {
            return string.Empty;
        }
    }

    #endregion

    #region 转换为double

    /// <summary>
    /// 将object转换为double，若转换失败，则返回0。不抛出异常。  
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static double ParseToDouble(this object obj)
    {
        try
        {
            return double.Parse(obj.ToString() ?? string.Empty);
        }
        catch
        {
            return 0;
        }
    }

    /// <summary>
    /// 将object转换为double，若转换失败，则返回指定值。不抛出异常。  
    /// </summary>
    /// <param name="str"></param>
    /// <param name="defaultValue"></param>
    /// <returns></returns>
    public static double ParseToDouble(this object str, double defaultValue)
    {
        try
        {
            return double.Parse(str.ToString() ?? string.Empty);
        }
        catch
        {
            return defaultValue;
        }
    }

    #endregion

    #region 强制转换类型

    /// <summary>
    /// 强制转换类型
    /// </summary>
    /// <typeparam name="TResult"></typeparam>
    /// <param name="source"></param>
    /// <returns></returns>
    public static IEnumerable<TResult> CastSuper<TResult>(this IEnumerable source)
    {
        return from object item in source select (TResult)Convert.ChangeType(item, typeof(TResult));
    }

    #endregion

    #region 转换为ToUnixTime

    public static long ParseToUnixTime(this DateTime nowTime)
    {
        var startTime = new DateTime(1970, 1, 1, 0, 0, 0, 0);
        return (long)Math.Round((nowTime - startTime).TotalMilliseconds, MidpointRounding.AwayFromZero);
    }

    #endregion
}
