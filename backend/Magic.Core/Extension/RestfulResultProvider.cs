using Furion.DataValidation;
using Furion.DependencyInjection;
using Furion.FriendlyException;
using Furion.UnifyResult;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Filters;
using System;
using System.Threading.Tasks;

namespace Magic.Core;

/// <summary>
/// 规范化RESTful风格返回值
/// </summary>
[SuppressSniffer, UnifyModel(typeof(XnRestfulResult<>))]
public class RestfulResultProvider : IUnifyResultProvider
{
    public IActionResult OnException(ExceptionContext context, ExceptionMetadata metadata)
    {
        // 解析异常信息
        var exceptionMetadata = UnifyContext.GetExceptionMetadata(context);

        return new JsonResult(new XnRestfulResult<object>
        {
            Code = exceptionMetadata.StatusCode,
            Success = false,
            Data = null,
            Message = exceptionMetadata.Errors,
            Extras = UnifyContext.Take(),
            Timestamp = DateTime.Now.Millisecond
        });
    }

    public IActionResult OnSucceeded(ActionExecutedContext context, object data)
    {
        switch (context.Result)
        {
            // 处理内容结果
            case ContentResult contentResult:
                data = contentResult.Content;
                break;
            // 处理对象结果
            case ObjectResult objectResult:
                data = objectResult.Value;
                break;
            case EmptyResult:
                data = null;
                break;
            default:
                return null;
        }

        return new JsonResult(new XnRestfulResult<object>
        {
            Code = context.Result is EmptyResult ? StatusCodes.Status204NoContent : StatusCodes.Status200OK,  // 处理没有返回值情况 204
            Success = true,
            Data = data,
            Message = "请求成功",
            Extras = UnifyContext.Take(),
            Timestamp = DateTime.Now.Millisecond
        });
    }

    public IActionResult OnValidateFailed(ActionExecutingContext context, ValidationMetadata metadata)
    {
        return new JsonResult(new XnRestfulResult<object>
        {
            Code = StatusCodes.Status400BadRequest,
            Success = false,
            Data = null,
            Message = metadata.ValidationResult,
            Extras = UnifyContext.Take(),
            Timestamp = DateTime.Now.Millisecond
        });
    }

    public async Task OnResponseStatusCodes(HttpContext context, int statusCode, UnifyResultSettingsOptions unifyResultSettings = null)
    {
        Console.WriteLine("OnResponseStatusCodes");
        // 设置响应状态码
        UnifyContext.SetResponseStatusCodes(context, statusCode, unifyResultSettings);

        if (Enum.IsDefined(typeof(HttpStatusCode), (HttpStatusCode)statusCode)){
            await context.Response.WriteAsJsonAsync(new XnRestfulResult<object>
            {
                Code = statusCode,
                Success = false,
                Data = null,
                Message = EnumUtil.GetDescription((HttpStatusCode)statusCode),
                Extras = UnifyContext.Take(),
                Timestamp = DateTime.Now.Millisecond
            });
        }
    }
}

/// <summary>
/// RESTful风格---XIAONUO返回格式
/// </summary>
/// <typeparam name="T"></typeparam>
[SuppressSniffer]
public class XnRestfulResult<T>
{
    /// <summary>
    /// 执行成功
    /// </summary>
    public bool Success { get; set; }

    /// <summary>
    /// 状态码
    /// </summary>
    public int? Code { get; set; }

    /// <summary>
    /// 错误信息
    /// </summary>
    public object Message { get; set; }

    /// <summary>
    /// 数据
    /// </summary>
    public T Data { get; set; }

    /// <summary>
    /// 附加数据
    /// </summary>
    public object Extras { get; set; }

    /// <summary>
    /// 时间戳
    /// </summary>
    public long Timestamp { get; set; }
}
