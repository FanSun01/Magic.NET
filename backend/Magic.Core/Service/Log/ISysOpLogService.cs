using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysOpLogService
{
    Task ClearOpLog();
    Task<dynamic> QueryOpLogPageList([FromQuery] OpLogInput input);
}
