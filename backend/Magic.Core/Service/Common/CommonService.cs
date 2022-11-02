using Furion;
using Furion.DependencyInjection;
using Microsoft.Extensions.Options;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public class CommonService : ICommonService, IScoped
{
    private readonly ICache _cache;
    public CommonService(IOptions<CacheOptions> cacheOptions, Func<string, ISingleton, object> resolveNamed, ISqlSugarClient sqlSugarClient)
    {
        _cache = resolveNamed(cacheOptions.Value.CacheType.ToString(), default) as ICache;
    }

    /// <summary>
    /// 获取库表信息
    /// </summary>
    /// <param name="IsCache"></param>
    /// <returns></returns>
    public async Task<IEnumerable<EntityInfo>> GetEntityInfos(bool IsCache = true)
    {
        List<EntityInfo> entityInfos = IsCache ? (await _cache.GetAsync<List<EntityInfo>>(CommonConst.CACHE_KEY_ENTITYINFO) ?? new List<EntityInfo>()) : new List<EntityInfo>();
        if (entityInfos != null && entityInfos.Any())
        {
            return entityInfos;
        }
        var type = typeof(SugarTable);
        List<Type> cosType = App.EffectiveTypes.Where(a => !a.IsAbstract && a.IsClass && a.GetCustomAttributes(typeof(SugarTable), true)?.FirstOrDefault() != null).ToList();
        foreach (var c in cosType)
        {
            var sugarAttribute = c.GetCustomAttributes(type, true)?.FirstOrDefault();

            var des = c.GetCustomAttributes(typeof(DescriptionAttribute), true);
            var description = "";
            if (des.Length > 0)
            {
                description = ((DescriptionAttribute)des[0]).Description;
            }
            entityInfos.Add(new EntityInfo()
            {
                EntityName = c.Name,
                DbTableName = sugarAttribute == null ? c.Name : ((SugarTable)sugarAttribute).TableName,
                TableDescription = description
            });
        }
        
        await _cache.SetAsync(CommonConst.CACHE_KEY_ENTITYINFO, entityInfos);
        
        return entityInfos;
    }
}
