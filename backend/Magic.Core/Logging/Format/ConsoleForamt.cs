using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Abstractions;
using Microsoft.Extensions.Logging.Console;
using Microsoft.Extensions.Options;
using System;
using System.IO;

namespace Magic.Core;

public class ConsoleForamt : ConsoleFormatter, IDisposable
{
    private CustomColorOptions _formatterOptions;
    private readonly IDisposable _optionsReloadToken;
    private bool ConsoleColorFormattingEnabled =>
        _formatterOptions.ColorBehavior == LoggerColorBehavior.Enabled ||
        _formatterOptions.ColorBehavior == LoggerColorBehavior.Default &&
        System.Console.IsOutputRedirected == false;

    private void ReloadLoggerOptions(CustomColorOptions options) =>
_formatterOptions = options;

    public ConsoleForamt(IOptionsMonitor<CustomColorOptions> options) : base("custom_format") =>
    (_optionsReloadToken, _formatterOptions) =
        (options.OnChange(ReloadLoggerOptions), options.CurrentValue);



    public override void Write<TState>(in LogEntry<TState> logEntry, IExternalScopeProvider scopeProvider, TextWriter textWriter)
    {
        string message = logEntry.Formatter?.Invoke(logEntry.State, logEntry.Exception);

        if (message is null)
        {
            return;
        }
        ConsoleColor color = ConsoleColor.White;
        switch (logEntry.LogLevel)
        {

            case LogLevel.Information:
                color = ConsoleColor.Green;
                break;
            case LogLevel.Warning:
                color = ConsoleColor.Yellow;
                break;
            case LogLevel.Error:
                color = ConsoleColor.Red;
                break;
        }

        textWriter.WriteWithColor("【日志级别】：" + logEntry.LogLevel, ConsoleColor.Black, color);
        textWriter.WriteWithColor("【日志时间】：" + DateTime.Now.ToString("yyyy:MM:dd:HH:mm:ss"), ConsoleColor.Black, color);
        textWriter.WriteWithColor("【日志内容】：" + message, ConsoleColor.Black, color);
        if (logEntry.Exception != null)
        {
            textWriter.WriteWithColor("【异常信息】：" + logEntry.Exception, ConsoleColor.Black, color);
        }
        textWriter.WriteLine();
    }


    public void Dispose()
    {
        _optionsReloadToken?.Dispose();
    }
}
