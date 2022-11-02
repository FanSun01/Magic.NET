using System.Collections.Generic;
using Mapster;
using SqlSugar;

namespace Magic.Core;

public class PageResult<T>
{
    public int PageNo { get; set; }
    public int PageSize { get; set; }
    public int TotalPage { get; set; }
    public int TotalRows { get; set; }
    public ICollection<T> Rows { get; set; }
}

/// <summary>
/// 小诺分页列表结果
/// </summary>
public static class PageResult
{
    /// <summary>
    /// 替换sqlsugar分页
    /// </summary>
    /// <param name="page"></param>
    /// <returns></returns>
    public static dynamic XnPagedResult<T>(this SqlSugarPagedList<T> page)
    {
        return new
        {
            PageNo = page.PageIndex,
            PageSize = page.PageSize,
            TotalPage = page.TotalPages,
            TotalRows = page.TotalCount,
            Rows = page.Items 
        };
    }
}
