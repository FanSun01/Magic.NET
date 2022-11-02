using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface IMachineService
{
    Task<dynamic> GetMachineBaseInfo();
    Task<dynamic> GetMachineNetWorkInfo();
    Task<dynamic> GetMachineUseInfo();
}
