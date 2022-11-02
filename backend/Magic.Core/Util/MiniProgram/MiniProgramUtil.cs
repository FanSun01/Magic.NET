using System;
using System.Security.Cryptography;
using System.Text;
using System.Text.Json.Serialization;
using Furion.JsonSerialization;

namespace Magic.Core;

/// <summary>
/// 小程序工具类
/// </summary>
public class MiniProgramUtil
{
    /// <summary>
    /// 解密数据获取小程序用户信息
    /// </summary>
    /// <param name="encryptedDataStr">包括敏感数据在内的完整用户信息的加密数据</param>
    /// <param name="session_key">auth.code2Session获取的session_key</param>
    /// <param name="iv">加密算法的初始向量</param>
    /// <returns>如遇异常返回 ""</returns>
    public static TelUserInfoModel AESDecrypt(string encryptedDataStr, string session_key, string iv)
    {
        var rlt = BasicAESDecrypt(encryptedDataStr, session_key, iv);
        return !rlt.IsEmpty() ? JSON.Deserialize<TelUserInfoModel>(rlt) : null;
    }

    /// <summary>
    /// 基础解析
    /// </summary>
    /// <param name="encryptedDataStr">包括敏感数据在内的完整用户信息的加密数据</param>
    /// <param name="session_key">auth.code2Session获取的session_key</param>
    /// <param name="iv">加密算法的初始向量</param>
    /// <returns></returns>
    private static string BasicAESDecrypt(string encryptedDataStr, string session_key, string iv)
    {
        // 16进制转换成byte
        var encryptedData = Convert.FromBase64String(encryptedDataStr);
        var managed = new RijndaelManaged
        {
            Key = Convert.FromBase64String(session_key),
            IV = Convert.FromBase64String(iv),
            Mode = CipherMode.CBC,
            Padding = PaddingMode.PKCS7
        };
        var transform = managed.CreateDecryptor();
        var finalBlock = transform.TransformFinalBlock(encryptedData, 0, encryptedData.Length);
        var result = Encoding.Default.GetString(finalBlock);
        return result;
    }
}

/// <summary>
/// 小程序登录解密后的用户信息Model
/// </summary>
public class TelUserInfoModel
{
    /// <summary>
    /// 手机号
    /// </summary>
    [JsonPropertyName("phoneNumber")]
    public string PhoneNumber { get; set; }

    /// <summary>
    /// 纯手机号
    /// </summary>
    [JsonPropertyName("purePhoneNumber")]
    public string PurePhoneNumber { get; set; }

    /// <summary>
    /// 区号
    /// </summary>
    [JsonPropertyName("countryCode")]
    public string CountryCode { get; set; }
}
