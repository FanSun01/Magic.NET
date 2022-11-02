﻿using System;
using System.Diagnostics;
using System.Security.Claims;
using System.Threading.Tasks;
using Furion;
using Furion.EventBus;
using Furion.JsonSerialization;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Controllers;
using Microsoft.AspNetCore.Mvc.Filters;
using UAParser;

namespace Magic.Core;

/// <summary>
/// 请求日志拦截
/// </summary>
public class RequestActionFilter : IAsyncActionFilter
{
    private readonly IEventPublisher _eventPublisher;

    public RequestActionFilter(IEventPublisher eventPublisher)
    {
        _eventPublisher = eventPublisher;
    }

    public async Task OnActionExecutionAsync(ActionExecutingContext context, ActionExecutionDelegate next)
    {
        var httpContext = context.HttpContext;
        var httpRequest = httpContext.Request;

        var sw = new Stopwatch();
        sw.Start();
        var actionContext = await next();
        sw.Stop();

        //判断是否请求成功（没有异常就是请求成功）
        var isRequestSucceed = actionContext.Exception == null;
        var headers = httpRequest.Headers;
        var clientInfo = headers.ContainsKey("User-Agent") ? Parser.GetDefault().Parse(headers["User-Agent"]) : null;
        var actionDescriptor = context.ActionDescriptor as ControllerActionDescriptor;
        var isWriteLog = false;
        var ip = HttpNewUtil.Ip;
        //判断是否需要记录操作日志属性
        foreach (var metadata in actionDescriptor.EndpointMetadata)
        {
            if (metadata.GetType() == typeof(OpLogAttribute))
            {
                isWriteLog = true;
                break;
            }
        }
        //请求异常时记录日志
        if (!isRequestSucceed || App.GetOptions<SystemSettingsOptions>().IsGlobalRequestLog)
        {
            isWriteLog = true;
        }
        if (isWriteLog)
        {
            await _eventPublisher.PublishAsync(new ChannelEventSource("Create:OpLog", new SysLogOp
            {
                Name = httpContext.User?.FindFirstValue(ClaimConst.CLAINM_NAME),
                Success = isRequestSucceed ? YesOrNot.Y : YesOrNot.N,
                Ip = ip,
                Location = httpRequest.GetRequestUrlAddress(),
                Browser = clientInfo?.UA.Family + clientInfo?.UA.Major,
                Os = clientInfo?.OS.Family + clientInfo?.OS.Major,
                Url = httpRequest.Path,
                ClassName = context.Controller.ToString(),
                MethodName = actionDescriptor?.ActionName,
                ReqMethod = httpRequest.Method,
                Param = JSON.Serialize(context.ActionArguments.Count < 1 ? "" : context.ActionArguments),
                Result = actionContext.Result?.GetType() == typeof(JsonResult) ? JSON.Serialize(actionContext.Result) : "",
                ElapsedTime = sw.ElapsedMilliseconds,
                OpTime = DateTime.Now,
                Account = httpContext.User?.FindFirstValue(ClaimConst.CLAINM_ACCOUNT)
            }));
        }
    }
}
