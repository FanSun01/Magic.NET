using System.Threading.Tasks;

namespace Magic.FlowCenter.Service;

public interface  IFlcCustomFormService
{
    Task Add(long flowInstanceId, string frmData);
    Task Edit(long flowInstanceId, string frmData);
}
