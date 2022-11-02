

using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 操作日志服务
/// </summary>
[ApiDescriptionSettings(Name = "OpLog", Order = 100)]
public class SysOpLogService : ISysOpLogService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysLogOp> _sysOpLogRep; // 操作日志表仓储

    public SysOpLogService(SqlSugarRepository<SysLogOp> sysOpLogRep)
    {
        _sysOpLogRep = sysOpLogRep;
    }

    /// <summary>
    /// 分页查询操作日志
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysOpLog/page")]
    public async Task<dynamic> QueryOpLogPageList([FromQuery] OpLogInput input)
    {
        var opLogs = await _sysOpLogRep.AsQueryable()
           .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
           .WhereIF(Enum.IsDefined(typeof(YesOrNot),input.Success), u => u.Success == input.Success)
           .WhereIF(!string.IsNullOrWhiteSpace(input.SearchBeginTime), u => u.OpTime >= DateTime.Parse(input.SearchBeginTime.Trim()) && u.OpTime <= DateTime.Parse(input.SearchEndTime.Trim()))
           .OrderBy(u => u.Id, OrderByType.Desc)
           .Select<OpLogOutput>()
           .ToPagedListAsync(input.PageNo, input.PageSize);

        return opLogs.XnPagedResult();
    }

    /// <summary>
    /// 清空操作日志
    /// </summary>
    /// <returns></returns>
    [HttpPost("/sysOpLog/delete")]
    public async Task ClearOpLog()
    {
        await _sysOpLogRep.DeleteAsync(m => true);
    }
}
