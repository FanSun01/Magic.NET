using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysExLogService
{
    Task ClearExLog();
    Task<dynamic> QueryExLogPageList([FromQuery] ExLogInput input);
}
