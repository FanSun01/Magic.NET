using Furion.JsonSerialization;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Reflection;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 表单工具
/// </summary>
	public class FormUtil {
    /// <summary>
    /// 获取值
    /// </summary>
    /// <param name="content"></param>
    /// <returns>System.String.</returns>
    public static List<string> SetValue(string content)
    {
        List<FormValue> list = JSON.GetJsonSerializer().Deserialize<List<FormValue>>(content);
        List<string> temp = new List<string>();
        SetFormValue(list, temp);
        return temp;
    }
    /// <summary>
    /// 表单赋值
    /// </summary>
    /// <param name="list"></param>
    /// <param name="temp"></param>
    /// <returns></returns>
    private static List<string> SetFormValue(List<FormValue> list, List<string> temp)
    {
        foreach (var item in list)
        {
            if (item.tag == "grid")
            {
                foreach (var column in item.columns)
                {
                    SetFormValue(column.list, temp);
                }
            }
            else
            {
                temp.Add(item.id);
            }
        }
        return temp;
    }
    /// <summary>
    /// 自定义表单设值
    /// </summary>
    /// <param name="webForm"></param>
    /// <returns></returns>
    public static List<string> SetValueByWeb(string webForm)
    {
        //首字母大写
        webForm = webForm.Substring(0, 1).ToUpper() + webForm.Substring(1);
        var path = AppDomain.CurrentDomain.RelativeSearchPath ?? AppDomain.CurrentDomain.BaseDirectory;
        var referencedAssemblies = Directory.GetFiles(path, "*.dll").Select(Assembly.LoadFrom).ToArray();
        var t = referencedAssemblies
            .SelectMany(a => a.GetTypes().Where(t => t.FullName.Contains("Magic.FlowCenter"+"." + webForm))).First();
        List<string> temp = new List<string>();
        PropertyInfo[] pArray = t.GetProperties();
        Array.ForEach<PropertyInfo>(pArray, p =>
        {
            temp.Add(p.Name);
        });
        return temp;
    }
}
