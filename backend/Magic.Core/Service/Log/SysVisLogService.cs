

using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 访问日志服务
/// </summary>
[ApiDescriptionSettings(Name = "VisLog", Order = 100)]
public class SysVisLogService : ISysVisLogService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysLogVis> _sysVisLogRep;  // 访问日志表仓储

    public SysVisLogService(SqlSugarRepository<SysLogVis> sysVisLogRep)
    {
        _sysVisLogRep = sysVisLogRep;
    }

    /// <summary>
    /// 分页查询访问日志
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysVisLog/page")]
    public async Task<dynamic> QueryVisLogPageList([FromQuery] VisLogInput input)
    {
       var visLogs = await _sysVisLogRep.AsQueryable()
                                         .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name))
                                         .WhereIF(input.VisType > 0, u => u.VisType == input.VisType)
                                         .WhereIF(input.Success != null && Enum.IsDefined(typeof(YesOrNot), input.Success), u => u.Success == input.Success)
                                         .WhereIF(!string.IsNullOrWhiteSpace(input.SearchBeginTime), u => u.VisTime >= DateTime.Parse(input.SearchBeginTime.Trim()) && u.VisTime <= DateTime.Parse(input.SearchEndTime.Trim()))
                                         .OrderBy(u => u.Id, OrderByType.Desc)
                                         .Select<VisLogOutput>()
                                         .ToPagedListAsync(input.PageNo, input.PageSize);
        return visLogs.XnPagedResult();
    }

    /// <summary>
    /// 清空访问日志
    /// </summary>
    /// <returns></returns>
    [HttpPost("/sysVisLog/delete")]
    public async Task ClearVisLog()
    {
        await _sysVisLogRep.DeleteAsync(m => true);
    }
}
