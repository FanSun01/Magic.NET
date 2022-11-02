using Microsoft.Extensions.DependencyInjection;
using System;

namespace Magic.Core;

/// <summary>
/// B格
/// </summary>
public static class BStyleServiceExtension
{
    public static void AddBStyle(this IServiceCollection services, Action<BStyleServiceBuilder> configure)
    {
        var builder = new BStyleServiceBuilder();
        configure(builder);
    }
}
public class BStyleServiceBuilder
{
    public void UseDefault()
    {
        Console.ForegroundColor = ConsoleColor.Blue;
        Console.WriteLine(@"  __  __                   _              _   _   ______   _______ 
 |  \/  |                 (_)            | \ | | |  ____| |__   __|
 | \  / |   __ _    __ _   _    ___      |  \| | | |__       | |   
 | |\/| |  / _` |  / _` | | |  / __|     | . ` | |  __|      | |   
 | |  | | | (_| | | (_| | | | | (__   _  | |\  | | |____     | |   
 |_|  |_|  \__,_|  \__, | |_|  \___| (_) |_| \_| |______|    |_|   
                    __/ |                                          
                   |___/      ");
        Console.ForegroundColor = ConsoleColor.Red;
        Console.WriteLine(@"

gitee: https://gitee.com/zhengguojing/magic-net");
        Console.ForegroundColor = ConsoleColor.Yellow;
        Console.WriteLine(@"期待您的PR，让.net更好！

");
    }

    public void UseOther()
    {
        System.Console.WriteLine(@"另一个BStyle");
    }
}