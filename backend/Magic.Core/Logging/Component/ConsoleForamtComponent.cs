using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Logging.Console;
using System;

namespace Magic.Core;

public sealed class ConsoleForamtComponent : IWebComponent
{
    public void Load(WebApplicationBuilder builder, ComponentContext componentContext)
    {
        //builder.Logging.ClearProviders();
        //builder.Logging.AddConsole(options =>
        //{
        //    options.FormatterName = "custom_format";
        //}).AddConsoleFormatter<ConsoleForamt, ConsoleFormatterOptions>();

    }


}
