using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysEnumDataService
{
    dynamic GetEnumTypeList();
    Task<dynamic> GetEnumDataList([FromQuery] EnumDataInput input);
    Task<dynamic> GetEnumDataListByField([FromQuery] QueryEnumDataInput input);
}
