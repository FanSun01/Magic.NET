using Magic.FlowCenter.Entity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
namespace Magic.FlowCenter.Service;

	public interface IFlcFlowinstanceService
{
    Task Add(FlcFlowinstance input);
    Task Delete(DeleteFlcFlowinstanceInput input);
    Task Cancel(DeleteFlcFlowinstanceInput input);
    Task Verification(Verification input);
    Task<dynamic> List([FromQuery] FlcFlowinstanceInput input);
    Task<dynamic> Page([FromQuery] FlcFlowinstanceInput input);
    Task Update(FlcFlowinstance input);
    Task<List<FlcFlowInstanceOperationHistory>> QueryHistories([FromQuery] QueryeFlcFlowinstanceInput input);
    Task<FlcFlowinstanceOutput> GetForVerification([FromQuery] QueryeFlcFlowinstanceInput input);
}
