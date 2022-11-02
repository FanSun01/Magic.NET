using System.Collections.Generic;
using System.Linq;
using Furion.JsonSerialization;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;

namespace Magic.Core;

/// <summary>
/// Json序列化工具类
/// </summary>
public static class JsonUtil
{
    /// <summary>
    /// JSON 字符串转 Object
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="json"></param>
    /// <returns></returns>
    public static T ToObject<T>(this string json)
    {
        json = json.Replace("&nbsp;", "");
        return json == null ? default(T) : JsonConvert.DeserializeObject<T>(json);
    }
    /// <summary>
    /// JSON 字符串转 Object
    /// </summary>
    /// <param name="Json"></param>
    /// <returns></returns>
    public static object ToObject(this string Json)
    {
        return string.IsNullOrEmpty(Json) ? null : JsonConvert.DeserializeObject(Json);
    }
    /// <summary>
    /// Object 转 JSON字符串
    /// </summary>
    /// <param name="obj"></param>
    /// <returns></returns>
    public static string ToJsonString(this object obj)
    {
        return obj == null ? string.Empty : JsonConvert.SerializeObject(obj);
    }

    /// <summary>
    /// JSON 字符串转 JObject
    /// </summary>
    /// <param name="json"></param>
    /// <returns></returns>
    public static JObject ToJObject(this string json)
    {
        return json == null ? JObject.Parse("{}") : JObject.Parse(json.Replace("&nbsp;", ""));
    }

    /// <summary>
    /// Dictionary 字符串转 Object
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="dictionary"></param>
    /// <returns></returns>
    public static T ToObject<T>(this IDictionary<string, object> dictionary)
    {
        return dictionary.ToJsonString().ToObject<T>();
    }
    /// <summary>
    /// 把数组转为逗号连接的字符串
    /// </summary>
    /// <param name="data"></param>
    /// <param name="Str"></param>
    /// <returns></returns>
    public static string ArrayToString(dynamic data, string Str)
    {
        string resStr = Str;
        foreach (var item in data)
        {
            if (resStr != "")
            {
                resStr += ",";
            }

            if (item is string)
            {
                resStr += item;
            }
            else
            {
                resStr += item.ToString();
            }
        }
        return resStr;
    }
    /// <summary>
    /// 判断是否有交集
    /// </summary>
    /// <typeparam name="T"></typeparam>
    /// <param name="list1"></param>
    /// <param name="list2"></param>
    /// <returns></returns>
    public static bool IsArrayIntersection<T>(List<T> list1, List<T> list2)
    {
        List<T> t = list1.Distinct().ToList();

        var exceptArr = t.Except(list2).ToList();

        if (exceptArr.Count < t.Count)
        {
            return true;
        }
        else
        {
            return false;
        }

    }
}
