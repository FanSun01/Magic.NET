using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core;

/// <summary>
/// 缓存类型
/// </summary>
public enum CacheType
{
    /// <summary>
    /// 内存缓存
    /// </summary>
    MemoryCache,

    /// <summary>
    /// Redis缓存
    /// </summary>
    RedisCache
}
