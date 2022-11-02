
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
namespace Magic.Core.Service;

public interface ITrashService
{
    Task Delete(DeleteDocumentInput input);
    Task<dynamic> Page([FromQuery] DocumentInput input);
}
