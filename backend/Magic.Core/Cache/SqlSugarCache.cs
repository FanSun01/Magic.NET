using Furion;
using Furion.DependencyInjection;
using SqlSugar;
using System;
using System.Collections.Generic;

namespace Magic.Core;

public class SqlSugarCache : ICacheService
{
    private static ICache _cache = App.GetOptions<CacheOptions>().CacheType == CacheType.MemoryCache? App.RootServices.GetService(typeof(MemoryCache)) as ICache : App.RootServices.GetService(typeof(RedisCache)) as ICache;

		public void Add<TV>(string key, TV value)
    {
        _cache.Set(key, value);
    }

    public void Add<TV>(string key, TV value, int cacheDurationInSeconds)
    {
        _cache.Set(key, value,  TimeSpan.FromSeconds(cacheDurationInSeconds));
    }

    public bool ContainsKey<TV>(string key)
    {
        return _cache.Exists(key);
    }

    public TV Get<TV>(string key)
    {
        return _cache.Get<TV>(key);
    }

    public IEnumerable<string> GetAllKey<TV>()
    {

        return _cache.GetAllKeys();
    }

    public TV GetOrCreate<TV>(string cacheKey, Func<TV> create, int cacheDurationInSeconds = int.MaxValue)
    {
        if (this.ContainsKey<TV>(cacheKey))
        {
            return this.Get<TV>(cacheKey);
        }
        else
        {
            var result = create();
            this.Add(cacheKey, result, cacheDurationInSeconds);
            return result;
        }
    }

    public void Remove<TV>(string key)
    {
        _cache.Del(key);
    }
}

