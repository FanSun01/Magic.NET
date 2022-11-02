using Furion;
using Furion.DependencyInjection;
using Furion.EventBus;
using Furion.FriendlyException;
using Furion.Logging.Extensions;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Security.Claims;
using System.Text.RegularExpressions;
using System.Threading.Tasks;

namespace Magic.Core;

/// <summary>
/// 全局异常处理
/// </summary>
public class LogExceptionHandler : IGlobalExceptionHandler, ISingleton
{
    private readonly IEventPublisher _eventPublisher;

    public LogExceptionHandler(IEventPublisher eventPublisher)
    {
        _eventPublisher = eventPublisher;
    }

    public async Task OnExceptionAsync(ExceptionContext context)
    {
        var userContext = App.User;
        var className = context.Exception.TargetSite.DeclaringType?.FullName;
        var groupCollection = Regex.Match(className, "<(.*?)>").Groups;
        var methodName = "";
        if (groupCollection.Count > 1)
        {
            methodName = groupCollection[1].Value;
        }
        await _eventPublisher.PublishAsync(new ChannelEventSource("Create:ExLog",
            new SysLogEx
            {
                Account = userContext?.FindFirstValue(ClaimConst.CLAINM_ACCOUNT),
                Name = userContext?.FindFirstValue(ClaimConst.CLAINM_NAME),
                ClassName = className,
                MethodName = methodName,
                ExceptionName = context.Exception.Message,
                ExceptionMsg = context.Exception.Message,
                ExceptionSource = context.Exception.Source,
                StackTrace = context.Exception.StackTrace,
                ParamsObj = context.Exception.TargetSite.GetParameters().ToString(),
                ExceptionTime = DateTime.Now
            }));
    }
}
