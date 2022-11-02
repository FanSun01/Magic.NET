using Furion.DataEncryption;
using Magic.Core.Entity;
using Magic.Core.Service;
using Microsoft.AspNetCore.SignalR;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core;

/// <summary>
/// 聊天集线器
/// </summary>
public class ChatHub : Hub<IChatClient>
{
    private readonly ISysCacheService _cache;
    private readonly SqlSugarRepository<OnlineUser> _sysOnlineUerRep;  // 在线用户表仓储


    public ChatHub(ISysCacheService cache, SqlSugarRepository<OnlineUser> sysOnlineUerRep)
    {
        _sysOnlineUerRep = sysOnlineUerRep;
        _cache = cache;
    }

    /// <summary>
    /// 连接
    /// </summary>
    /// <returns></returns>
    public override async Task OnConnectedAsync()
    {
        var token = Context.GetHttpContext().Request.Query["access_token"];
        var claims = JWTEncryption.ReadJwtToken(token)?.Claims;
        var userId = claims.FirstOrDefault(e => e.Type == ClaimConst.CLAINM_USERID)?.Value;
        var account= claims.FirstOrDefault(e => e.Type == ClaimConst.CLAINM_ACCOUNT)?.Value;
        var name= claims.FirstOrDefault(e => e.Type == ClaimConst.CLAINM_NAME)?.Value;
        var tenantId= claims.FirstOrDefault(e => e.Type == ClaimConst.TENANT_ID)?.Value;
        var ip = HttpNewUtil.Ip;
        if (_sysOnlineUerRep.Any(m => m.Account == account && m.LastLoginIp == ip)) {
            await _sysOnlineUerRep.DeleteAsync(m => m.Account == account && m.LastLoginIp == ip);
        }

        OnlineUser user = new OnlineUser() {
            ConnectionId = Context.ConnectionId,
            UserId = long.Parse(userId),
            LastTime = DateTime.Now,
            LastLoginIp= ip,
            Account= account,
            Name=name,
            TenantId=Convert.ToInt64(tenantId)
        };
        await _sysOnlineUerRep.InsertAsync(user);
    }

    /// <summary>
    /// 断开
    /// </summary>
    /// <param name="exception"></param>
    /// <returns></returns>
    public override async Task OnDisconnectedAsync(Exception exception)
    {
        if (!string.IsNullOrEmpty(Context.ConnectionId))
        {
           await _sysOnlineUerRep.DeleteAsync(m => m.ConnectionId == Context.ConnectionId);
        }
    }

}
