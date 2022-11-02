using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;
namespace Magic.FlowCenter.Service;

	public interface IFlcFlowschemeService
{
    Task Add(AddFlcFlowschemeInput input);
    Task Delete(DeleteFlcFlowschemeInput input);
    Task<FlcFlowschemeOutput> Get([FromQuery] DeleteFlcFlowschemeInput input);
    Task<List<FlcFlowschemeOutput>> List([FromQuery] FlcFlowschemeInput input);
    Task<dynamic> Page([FromQuery] PageFlcFlowschemeInput input);
    Task Update(UpdateFlcFlowschemeInput input);
}
