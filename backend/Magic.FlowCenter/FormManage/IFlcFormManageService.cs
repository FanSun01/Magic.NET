using Magic.FlowCenter.Entity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.FlowCenter.Service;

	public interface IFlcFormManageService
{
    Task AddForm(AddFlcFormInput input);
    Task DeleteForm(DeleteFlcFormInput input);
    Task<FlcForm> GetForm([FromQuery] QueryFlcFormInput input);
    Task<List<FlcFormOutput>> GetFormList([FromQuery] FlcFormInput input);
    Task<dynamic> QueryFormPageList([FromQuery] PageFlcFormInput input);
}
