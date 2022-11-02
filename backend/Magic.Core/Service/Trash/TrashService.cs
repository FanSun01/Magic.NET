
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.EventBus;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using SqlSugar;
using System;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 回收站服务
/// </summary>
[ApiDescriptionSettings(Name = "Trash", Order = 150)]
public class TrashService : ITrashService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<Documentation> _rep;
    private readonly IDocumentService _documentService;
    private readonly IEventPublisher _eventPublisher;
    private readonly ILogger<TrashService> _logger;
    public TrashService(ILogger<TrashService> logger, SqlSugarRepository<Documentation> rep, IDocumentService documentService, IEventPublisher eventPublisher)
    {
        this._logger = logger;
        _rep = rep;
        this._documentService = documentService;
        this._eventPublisher = eventPublisher;
    }
    #region API
    /// <summary>
    /// 分页查询回收站
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/Trash/page")]
    public async Task<dynamic> Page([FromQuery] DocumentInput input)
    {
        input.IsDelete = true;
        input.PId = null;
        var result = await _documentService.Page(input);
        return result;
    }


    /// <summary>
    /// 恢复一个
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Trash/recover")]
    public async Task Recover(DeleteDocumentInput input)
    {
        var entity = await _rep.AsQueryable().Filter(null, true).Where(it => it.Id == input.Id).FirstAsync();
        if (entity != null)
        {
            var exist = await _rep.AnyAsync(it => it.PId == entity.PId && it.Name == entity.Name);
            if (exist)
            {
                if (entity.DocumentType == DocumentType.Folder)
                {
                    entity.Name += $"({ DateTime.Now.ToString("yyyyMMddHHmmss")})";//如果是文件夹直接后面加
                }
                else
                {
                    var sp = entity.Name.Split(".");
                    entity.Name = $"({sp[0]}{ DateTime.Now.ToString("yyyyMMddHHmmss")}).{sp[1]}";
                }
            }
            entity.IsDeleted = false;
            await _rep.UpdateAsync(entity);
        }
        else
        {
            throw Oops.Oh("ErrorMessage.E404");
        }
    }

    /// <summary>
    /// 恢复多个
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Trash/recovers")]
    public async Task Recovers(DeletesDocumentInput input)
    {
        var documents = await _rep.AsQueryable().Filter(null, true).Where(it => input.Ids.Contains(it.Id)).ToListAsync();
        var docGroup = documents.GroupBy(it => it.PId).ToList();
        docGroup.ForEach(it =>
        {
            var docs = it.ToList();
            var i = 0;
            docs.ForEach(doc =>
            {
                var document = documents.Where(u => u.Id == doc.Id).First();
                var existDb = _rep.Any(it => it.PId == doc.PId && it.Name == doc.Name);//先判断数据库有没有重名
                var exist = docs.Any(it => it.Id != doc.Id && it.Name == doc.Name);//判断列表有没有重名
                if (existDb || exist)
                {
                    document.Name = Ren(doc.Name, i);
                }
                document.IsDeleted = false;
                i++;
            });
        });
        await _rep.UpdateAsync(documents);
    }


    /// <summary>
    /// 永久删除
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Trash/delete")]
    public async Task Delete(DeleteDocumentInput input)
    {
        var file = await _rep.AsQueryable().Filter(null, true).Where(u => u.Id == input.Id).FirstAsync();
        if (file != null)
        {
            file.Visible = false;
            await _rep.UpdateAsync(file);//删除当前
            //await _eventPublisher.PublishAsync(new ChannelEventSource(ZxzyConst.Event_Doc_Delete, file));//事件总线里删除子集
        }
        else
        {
            throw Oops.Oh("ErrorMessage.E404");
        }

    }

    /// <summary>
    ///批量删除
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Trash/deletes")]
    public async Task Deletes(DeletesDocumentInput input)
    {
        await _rep.UpdateAsync(it => input.Ids.Contains(it.Id), it => new Documentation
        {
            Visible = false
        });//删除当前
        //await _eventPublisher.PublishAsync(new ChannelEventSource(ZxzyConst.Event_Doc_Deletes, input.Ids));//事件总线里删除子集
    }

    /// <summary>
    /// 清空
    /// </summary>
    /// <returns></returns>
    [HttpPost("/Trash/empty")]
    public async Task Empty()
    {
        await _rep.UpdateAsync(it => it.IsDeleted == true,it=>new Documentation {
			Visible = false
		});//删除当前
        //await _eventPublisher.PublishAsync(new ChannelEventSource(ZxzyConst.Event_Doc_Empty));//事件总线里删除子集
    }
    #endregion
    #region 方法


    /// <summary>
    /// 重命名
    /// </summary>
    /// <param name="name"></param>
    /// <param name="i"></param>
    /// <returns></returns>
    [NonAction]
    private string Ren(string name, int i)
    {
        if (i == 0)
        {
            return name + $"({DateTime.Now.ToString("yyyyMMddHHmmss")})";
        }
        else
        {
            return name + $"({DateTime.Now.ToString("yyyyMMddHHmmss")})({i})";
        }

    }
    #endregion
}
