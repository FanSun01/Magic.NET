using Furion;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 枚举值服务
/// </summary>
[ApiDescriptionSettings(Name = "EnumData", Order = 1000)]
[AllowAnonymous]
public class SysEnumDataService : ISysEnumDataService, IDynamicApiController, ITransient
{


    /// <summary>
    /// 获取所有枚举值
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysEnumData/enumTypeList")]
    public dynamic GetEnumTypeList()
    {

        List<dynamic> result = new List<dynamic>();
        var enumTypeList = App.EffectiveTypes.Where(t => t.IsEnum && t.FullName.StartsWith("Magic.")).ToList();

        foreach (var item in enumTypeList)
        {
            result.Add(GetEnumDescription(item));
        }
        return result;
    }

    private dynamic GetEnumDescription(Type type)
    {

        string description = type.Name;
        var attrs = type.GetCustomAttributes(typeof(DescriptionAttribute), false);
        if (!attrs.IsNullOrZero() && attrs.Any())
        {
            //获取到：超级管理员
            var att = ((DescriptionAttribute[])attrs)[0];
            description = att.Description;
        }
        return new
        {
            Name = description,
            Code = type.Name,
            Sort = 100,
            Remark = description
        };
    }

    /// <summary>
    /// 通过枚举类型获取枚举值集合
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysEnumData/list")]
    public async Task<dynamic> GetEnumDataList([FromQuery] EnumDataInput input)
    {
        // 查找枚举
        var enumType = App.EffectiveTypes.FirstOrDefault(t => t.IsEnum && t.Name == input.EnumName);
        if (enumType == null)
            throw Oops.Oh(ErrorCode.D1502).StatusCode(405);

        //// 获取枚举的Key和描述
        return await Task.Run(() =>
               EnumExtensions.GetEnumDescDictionary(enumType)
               .Select(x => new EnumDataOutput
               {
                   Code = x.Key,
                   Value = x.Value
               }));
    }

    /// <summary>
    /// 通过实体字段类型获取相关集合（目前仅支持枚举类型）
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysEnumData/listByFiled")]
    public async Task<dynamic> GetEnumDataListByField([FromQuery] QueryEnumDataInput input)
    {

        // 获取实体类型属性
        Type entityType = null;

        foreach (var item in CommonConst.ENTITY_ASSEMBLY_NAME)
        {
            entityType = Type.GetType($"{item}.Entity.{input.EntityName}");
            if (entityType != null)
                break;
        }
        if (entityType == null) throw Oops.Oh(ErrorCode.D1504);

        // 获取字段类型
        var fieldType = entityType.GetProperties().FirstOrDefault(p => p.Name == input.FieldName)?.PropertyType;
        if (fieldType is not { IsEnum: true })
            throw Oops.Oh(ErrorCode.D1503);

        // 获取枚举的Key和描述
        return await Task.Run(() =>
               EnumExtensions.GetEnumDescDictionary(fieldType)
               .Select(x => new EnumDataOutput
               {
                   Code = x.Key,
                   Value = x.Value
               }));
    }
}
