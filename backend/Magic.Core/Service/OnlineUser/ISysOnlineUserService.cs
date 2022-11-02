using Magic.Core.Entity;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysOnlineUserService
{
    Task<dynamic> List(PageInputBase input);

    Task ForceExist(OnlineUser user);

    Task PushNotice(SysNotice notice, List<long> userIds);
}
