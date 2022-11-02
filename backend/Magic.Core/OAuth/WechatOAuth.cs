using Furion.DependencyInjection;
using Furion.FriendlyException;
using Furion.RemoteRequest.Extensions;
using Microsoft.Extensions.Options;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core;

public class WechatOAuth : IWechatOAuth, ISingleton
{
    private readonly string _authorizeUrl = "https://open.weixin.qq.com/connect/oauth2/authorize";
    private readonly string _accessTokenUrl = "https://api.weixin.qq.com/sns/oauth2/access_token";
    private readonly string _refreshTokenUrl = "https://api.weixin.qq.com/sns/oauth2/refresh_token";
    private readonly string _userInfoUrl = "https://api.weixin.qq.com/sns/userinfo";

    private readonly ThirdParty _oauthConfig;

    public WechatOAuth(IOptions<OAuthOptions> options)
    {
        _oauthConfig = options.Value.Wechat;
    }

    /// <summary>
    /// 发起授权
    /// </summary>
    /// <param name="state"></param>
    /// <returns></returns>
    public string GetAuthorizeUrl(string state = "")
    {
        var param = new Dictionary<string, string>()
        {
            ["appid"] = _oauthConfig.app_id,
            ["redirect_uri"] = _oauthConfig.redirect_uri,
            ["response_type"] = "code",
            ["scope"] = _oauthConfig.scope,
            ["state"] = state
        };
        return $"{_authorizeUrl}?{param.ToQueryString()}#wechat_redirect";
    }

    /// <summary>
    /// 获取微信Token
    /// </summary>
    /// <param name="code"></param>
    /// <param name="state"></param>
    /// <returns></returns>
    public async Task<TokenModel> GetAccessTokenAsync(string code, string state = "")
    {
        var param = new Dictionary<string, string>()
        {
            ["appid"] = _oauthConfig.app_id,
            ["secret"] = _oauthConfig.app_key,
            ["code"] = code,
            ["grant_type"] = "authorization_code"
        };
        var accessTokenModel = await $"{_accessTokenUrl}?{param.ToQueryString()}".GetAsAsync<TokenModel>();
        if (accessTokenModel.HasError())
            throw Oops.Oh($"{ accessTokenModel.ErrorDescription}");
        return accessTokenModel;
    }

    /// <summary>
    /// 获取微信用户基本信息
    /// </summary>
    /// <param name="accessToken"></param>
    /// <param name="openId"></param>
    /// <returns></returns>
    public async Task<UserInfoModel> GetUserInfoAsync(string accessToken, string openId)
    {
        var param = new Dictionary<string, string>()
        {
            ["access_token"] = accessToken,
            ["openid"] = openId,
            ["lang"] = "zh_CN",
        };
        var userInfoModel = await $"{_userInfoUrl}?{param.ToQueryString()}".GetAsAsync<UserInfoModel>();
        if (userInfoModel.HasError())
            throw Oops.Oh($"{ userInfoModel.ErrorMessage}");
        return userInfoModel;
    }

    /// <summary>
    /// 刷新微信Token
    /// </summary>
    /// <param name="refreshToken"></param>
    /// <returns></returns>
    public async Task<TokenModel> GetRefreshTokenAsync(string refreshToken)
    {
        var param = new Dictionary<string, string>()
        {
            ["appid"] = _oauthConfig.app_id,
            ["grant_type"] = "refresh_token",
            ["refresh_token"] = refreshToken
        };
        var refreshTokenModel = await $"{_refreshTokenUrl}?{param.ToQueryString()}".GetAsAsync<TokenModel>();
        if (refreshTokenModel.HasError())
            throw Oops.Oh($"{ refreshTokenModel.ErrorDescription}");
        return refreshTokenModel;
    }
}
