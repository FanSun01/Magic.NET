using Furion.EventBus;
using Magic.Core.Entity;
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Threading.Tasks;

namespace Magic.Core;

public class LogEventSubscriber : IEventSubscriber
{
    public LogEventSubscriber(IServiceProvider services)
    {
        Services = services;
    }

    public IServiceProvider Services { get; }

    [EventSubscribe("Create:OpLog")]
    public async Task CreateOpLog(EventHandlerExecutingContext context)
    {
        using var scope = Services.CreateScope();
        var _repository = scope.ServiceProvider.GetRequiredService<SqlSugarRepository<SysLogOp>>();
        var log = (SysLogOp)context.Source.Payload;
        await _repository.InsertAsync(log);
    }

    [EventSubscribe("Create:ExLog")]
    public async Task CreateExLog(EventHandlerExecutingContext context)
    {
        using var scope = Services.CreateScope();
        var _repository = scope.ServiceProvider.GetRequiredService<SqlSugarRepository<SysLogEx>>();
        var log = (SysLogEx)context.Source.Payload;
        await _repository.InsertAsync(log);
    }

    [EventSubscribe("Create:VisLog")]
    public async Task CreateVisLog(EventHandlerExecutingContext context)
    {
        using var scope = Services.CreateScope();
        var _repository = scope.ServiceProvider.GetRequiredService<SqlSugarRepository<SysLogVis>>();
        var log = (SysLogVis)context.Source.Payload;
        await _repository.InsertAsync(log);
    }

    [EventSubscribe("Update:UserLoginInfo")]
    public async Task UpdateUserLoginInfo(EventHandlerExecutingContext context)
    {
        using var scope = Services.CreateScope();
        var _repository = scope.ServiceProvider.GetRequiredService<SqlSugarRepository<SysUser>>();
        var log = (SysUser)context.Source.Payload;
		await _repository.UpdateAsync(a => a.Id == log.Id, a => new SysUser
		{
			LastLoginTime = log.LastLoginTime,
			LastLoginIp = log.LastLoginIp
		});
	}
}
