

using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 异常日志服务
/// </summary>
[ApiDescriptionSettings(Name = "ExLog", Order = 100)]
public class SysExLogService : ISysExLogService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysLogEx> _sysExLogRep;  // 操作日志表仓储

    public SysExLogService(SqlSugarRepository<SysLogEx> sysExLogRep)
    {
        _sysExLogRep = sysExLogRep;
    }

    /// <summary>
    /// 分页查询异常日志
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysExLog/page")]
    public async Task<dynamic> QueryExLogPageList([FromQuery] ExLogInput input)
    {
        var exLogs = await _sysExLogRep.AsQueryable()
                                       .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
                                       .WhereIF(!string.IsNullOrWhiteSpace(input.ClassName), u => u.ClassName == input.ClassName)
                                       .WhereIF(!string.IsNullOrWhiteSpace(input.MethodName), u => u.MethodName == input.MethodName)
                                       .WhereIF(!string.IsNullOrWhiteSpace(input.ExceptionMsg), u => u.ExceptionMsg.Contains(input.ExceptionMsg.Trim()))
                                       .WhereIF(!string.IsNullOrWhiteSpace(input.SearchBeginTime), u => u.ExceptionTime >= DateTime.Parse(input.SearchBeginTime.Trim()) &&
                                                               u.ExceptionTime <= DateTime.Parse(input.SearchEndTime.Trim()))
                                       .OrderBy(u => u.Id, OrderByType.Desc)
                                       .Select<ExLogOutput>()
                                       .ToPagedListAsync(input.PageNo, input.PageSize);
        return exLogs.XnPagedResult();
    }

    /// <summary>
    /// 清空异常日志
    /// </summary>
    /// <returns></returns>
    [HttpPost("/sysExLog/delete")]
    public async Task ClearExLog()
    {
        await _sysExLogRep.DeleteAsync(m => true);
    }
}
