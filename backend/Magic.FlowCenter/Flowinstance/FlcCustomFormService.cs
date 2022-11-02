using Furion.DependencyInjection;
using Magic.Core;
using Magic.FlowCenter.Entity;
using System;
using System.Threading.Tasks;
using Yitter.IdGenerator;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 自定义表格服务
/// </summary>
public class FlcCustomFormService : IFlcCustomFormService, ITransient
{
    private readonly SqlSugarRepository<FlcCustomForm> _rep;

    public FlcCustomFormService(SqlSugarRepository<FlcCustomForm> rep)
    {
        _rep = rep;
    }
    /// <summary>
    /// 新增
    /// </summary>
    /// <param name="flowInstanceId"></param>
    /// <param name="frmData"></param>
    /// <returns></returns>
    public async Task Add(long flowInstanceId, string frmData)
    {
        var req = frmData.ToObject<FlcCustomForm>();
        req.FlowInstanceId = flowInstanceId;
        req.Id = YitIdHelper.NextId();
        req.CreatedUserId = UserManager.UserId;
        req.CreatedUserName = UserManager.Name;
        req.CreatedTime = DateTime.Now;
        await _rep.InsertAsync(req);
    }
    /// <summary>
    /// 编辑
    /// </summary>
    /// <param name="flowInstanceId"></param>
    /// <param name="frmData"></param>
    /// <returns></returns>
    public async Task Edit(long flowInstanceId, string frmData)
    {
        var req = frmData.ToObject<FlcCustomForm>();
        req.FlowInstanceId = flowInstanceId;
        await _rep.UpdateAsync(a => a.FlowInstanceId == req.FlowInstanceId, a => new FlcCustomForm
        {
            Remark = a.Remark,
            Sort = a.Sort,
            Name = a.Name

        });
    }
}
