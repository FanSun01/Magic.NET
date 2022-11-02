using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysVisLogService
{
    Task ClearVisLog();
    Task<dynamic> QueryVisLogPageList([FromQuery] VisLogInput input);
}
