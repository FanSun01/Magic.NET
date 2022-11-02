
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Magic.Core.Entity;
using Magic.Core.Service;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;

using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 在线用户服务
/// </summary>
[ApiDescriptionSettings(Name = "OnlineUser", Order = 100)]
public class SysOnlineUserService : ISysOnlineUserService, IDynamicApiController, ITransient
{
    private readonly ISysCacheService _sysCacheService;
    private readonly SqlSugarRepository<OnlineUser> _sysOnlineUerRep;  // 在线用户表仓储
    private readonly IHubContext<ChatHub, IChatClient> _chatHubContext;

    public SysOnlineUserService(ISysCacheService sysCacheService
        ,SqlSugarRepository<OnlineUser> sysOnlineUerRep
        , IHubContext<ChatHub, IChatClient> chatHubContext)
    {
        _sysCacheService = sysCacheService;
        _sysOnlineUerRep = sysOnlineUerRep;
        _chatHubContext = chatHubContext;
    }

    /// <summary>
    /// 获取在线用户信息
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysOnlineUser/list")]
    public async Task<dynamic> List([FromQuery] PageInputBase input)
    {
        var list = await _sysOnlineUerRep.AsQueryable().ToPagedListAsync(input.PageNo, input.PageSize);
        return list.XnPagedResult();
    }

    [HttpPost("/sysOnlineUser/forceExist")]
    [NonValidation]
    public async Task ForceExist(OnlineUser user) {
        await _chatHubContext.Clients.Client(user.ConnectionId).ForceExist("7777777");
        await _sysOnlineUerRep.DeleteAsync(user);
    }

    [NonAction]
    public async Task PushNotice(SysNotice notice,List<long> userIds)
    {
        var userList = _sysOnlineUerRep.Where(m => userIds.Contains(m.UserId)).ToList();
        if (userList.Any()) {
            foreach (var item in userList)
            {
                await _chatHubContext.Clients.Client(item.ConnectionId).AppendNotice(notice);
            }
        }
        
    }
}
