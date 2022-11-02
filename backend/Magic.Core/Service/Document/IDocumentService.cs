
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;
using System.Threading.Tasks;
namespace Magic.Core.Service;

public interface IDocumentService
{
    Task<long> Add(AddDocumentInput input);
    Task Delete(DeleteDocumentInput input);
    Task<Documentation> Get([FromQuery] QueryeDocumentInput input);
    Task<dynamic> Page([FromQuery] DocumentInput input);
    Task Update(UpdateDocumentInput input);
}
