using Microsoft.AspNetCore.Mvc;

namespace Magic.Web.Entry.Controllers;

[Route("api/[controller]")]
[ApiController]
public class ValuesController : ControllerBase
{
    [HttpGet]
    public string GetName() {
        return nameof(Furion);
    }
}
