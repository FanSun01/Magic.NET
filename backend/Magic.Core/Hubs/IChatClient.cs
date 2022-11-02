using Magic.Core.Entity;
using System.Threading.Tasks;

namespace Magic.Core;

public interface IChatClient
{
    Task ForceExist(string str);

    Task AppendNotice(SysNotice notice);
}
