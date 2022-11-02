using Furion.Logging;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.Extensions.Logging;
using System;
using System.Text;

namespace Magic.Core;

/// <summary>
/// 日志写入文件的组件
/// </summary>
public sealed class LoggingFileComponent : IServiceComponent
{
    public void Load(IServiceCollection services, ComponentContext componentContext)
    {
        // 日志记录
        // 每天创建一个日志文件
        services.AddLogging(builder =>
        {
            builder.AddFile("logs/error/{0:yyyyMMdd}_.log", options =>
            {
                SetLogOptions(options, LogLevel.Error);
            });
            builder.AddFile("logs/info/{0:yyyyMMdd}_.log", options =>
            {
                SetLogOptions(options, LogLevel.Information);
            });
            builder.AddFile("logs/warn/{0:yyyyMMdd}_.log", options =>
            {
                SetLogOptions(options, LogLevel.Warning);
            });
        });
    }

    private void SetLogOptions(FileLoggerOptions options, LogLevel logLevel)
    {
        options.WriteFilter = (logMsg) =>
        {
            return logMsg.LogLevel == logLevel;
        };
        options.FileNameRule = fileName =>
        {
            return string.Format(fileName, DateTime.UtcNow);
        };
        options.FileSizeLimitBytes = 500 * 1024;
        //options.MessageFormat = LoggerFormatter.Json;
        //options.MessageFormat = (logMsg) =>
        //{
        //    var stringBuilder = new StringBuilder();
        //    stringBuilder.AppendLine("【日志级别】：" + logMsg.LogLevel);
        //    stringBuilder.AppendLine("【日志时间】：" + DateTime.Now.ToString("yyyy:MM:dd:HH:mm:ss"));
        //    stringBuilder.AppendLine("【日志内容】：" + logMsg.Message);
        //    if (logMsg.Exception != null)
        //    {
        //        stringBuilder.AppendLine("【异常信息】：" + logMsg.Exception);
        //    }
        //    return stringBuilder.ToString();
        //};
    }
}
