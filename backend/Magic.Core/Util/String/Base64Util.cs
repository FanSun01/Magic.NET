using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using Newtonsoft.Json;

namespace Magic.Core;

public static class Base64Util
{
    // 随机字符长度
    public const int RandomPrefixStrLength = 6;

    public const string RandomStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz";

    private static string GetRandomStr(string randomStr = RandomStr, int randomPrefixStrLength = RandomPrefixStrLength)
    {
        // ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=
        var result = "";
        var random = new Random(Convert.ToInt32($"{DateTime.Now:HHmmssfff}"));

        for (var i = 0; i < randomPrefixStrLength; i++)
        {
            var randomInt = random.Next(0, randomStr.Length);
            var randomChar = randomStr[randomInt];
            result += randomChar;
        }

        Thread.Sleep(1); // 休眠,以使随机数不重叠.

        return result;
    }

    static readonly Encoding encoding = Encoding.UTF8;

    /// <summary>
    /// 普通 字符串 转换为 base64 字符串
    /// </summary>
    public static string ToBase64(this string str, int randomPrefixStrLength = RandomPrefixStrLength)
    {
        if (string.IsNullOrWhiteSpace(str))
        {
            return "";
        }

        try
        {
            var randomPrefixStr = GetRandomStr(RandomStr, randomPrefixStrLength);
            var buffer = encoding.GetBytes(str);
            var base64Str = Convert.ToBase64String(buffer);

            base64Str = randomPrefixStrLength == 0 ? base64Str : InsertRandomStrToBase64Str(base64Str);

            return $"{randomPrefixStr}{base64Str}";
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Base64Utility.ToBase64: {ex}");
        }

        return string.Empty;
    }

    /// <summary>
    /// base64 字符串 转换为 普通 字符串
    /// </summary>
    public static string Base64ToString(this string base64Str, int randomPrefixStrLength = RandomPrefixStrLength)
    {
        var result = base64Str.Trim();
        try
        {
            if (string.IsNullOrWhiteSpace(base64Str?.Trim()))
            {
                return "";
            }

            base64Str = base64Str?.Trim();
            var input = base64Str?.Substring(randomPrefixStrLength);

            input = randomPrefixStrLength == 0 ? input : RemoveBase64StrRandomStr(input);
            var buffer = Convert.FromBase64String(input);
            result = encoding.GetString(buffer);
        }
        catch (Exception ex)
        {
            Console.WriteLine($"Base64Utility.Base64ToString: {ex}");
        }

        return result;
    }

    public struct PwdDic
    {
        [JsonProperty("version")]
        public string Version { get; set; }

        [JsonProperty("item")]
        public List<PwdDicItem> Item { get; set; }
    }

    public struct PwdDicItem
    {
        [JsonProperty("index")]
        public int Index { get; set; }

        [JsonProperty("randomIndex")]
        public int RandomIndex { get; set; }
    }

    public static readonly PwdDic dic = new PwdDic
    {
        Version = "3",
        Item = new List<PwdDicItem>
        {
            // 100 以内字典
            new() {Index = 99, RandomIndex = 91},
            new() {Index = 77, RandomIndex = 66},
            new() {Index = 45, RandomIndex = 37},
            new() {Index = 22, RandomIndex = 12},
            new() {Index = 5, RandomIndex = 3}
            // 这里的 RandomIndex 要比 Index 小，而且Index 和 RandomIndex 所有的Value都是唯一的，不能重复。
            // 由于这里开源，所以这个字典需要自行定义。
        }
    };

    private static string InsertRandomStrToBase64Str(string base64Str)
    {
        var strResult = $"{base64Str}";

        dic.Item.ForEach(item =>
        {
            if (item.Index < base64Str.Length)
            {
                var randomChar = base64Str[item.RandomIndex];
                strResult = strResult.Insert(item.Index, $"{randomChar}");
            }
        });

        return strResult;
    }

    private static string RemoveBase64StrRandomStr(string input)
    {
        var items = dic.Item.OrderBy(x => x.Index).ToList();

        var strResult = $"{input}";

        items.ForEach(item =>
        {
            if (item.Index < strResult.Length)
            {
                strResult = strResult.Remove(item.Index, 1);
            }
        });

        return strResult;
    }
}
