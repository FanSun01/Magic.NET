using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core;
using Magic.Core.Entity;
using Magic.Core.Service;
using Magic.FlowCenter.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 流程管理服务
/// </summary>
[ApiDescriptionSettings("FlowCenter", Name = "Flowscheme", Order = 100)]
public class FlcFlowschemeService : IFlcFlowschemeService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<FlcFlowscheme> _rep;
    private readonly IFlcFormManageService _flcFormService;
    private readonly ISysEmpService _sysEmpService;

    public FlcFlowschemeService(SqlSugarRepository<FlcFlowscheme> flcFormRep,
                        IFlcFormManageService flcFormService,
                         ISysEmpService sysEmpService)
    {
        _rep = flcFormRep;
        _flcFormService = flcFormService;
        _sysEmpService = sysEmpService;
    }

    /// <summary>
    /// 分页查询流程管理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowscheme/page")]
    public async Task<dynamic> Page([FromQuery] PageFlcFlowschemeInput input)
    {
        var entities = await _rep.AsQueryable()
            .LeftJoin<FlcForm>((u,b)=>u.FrmId==b.Id)
                                    .WhereIF(!string.IsNullOrWhiteSpace(input.SchemeName), u => u.SchemeName.Contains(input.SchemeName.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Id), u => u.Id == long.Parse(input.Id.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.OrgId), u => u.OrgId == long.Parse(input.OrgId) || u.OrgId == null || u.OrgId == 0)
                                    .WhereIF(input.Status != null, u => u.Status == input.Status)
                                   .Where(u => u.Status != CommonStatus.DELETED)
                                   .OrderBy(u => u.Sort)
                                   .Select<FlcFlowschemeOutput>((u,b)=>new FlcFlowschemeOutput { 
                                        Id=u.Id.ToString(),
                                        Active=u.Active,
                                        AuthorizeType=u.AuthorizeType,
                                        FrmId=u.FrmId.ToString(),
                                        Name=b.Name,
                                        WebId = b.WebId,
                                        FrmType =u.FrmType,
                                        OrgId=u.OrgId.ToString(),
                                        Remark=u.Remark,
                                        SchemeCanUser=u.SchemeCanUser,
                                        SchemeCode=u.SchemeCode,
                                        SchemeContent=u.SchemeContent,
                                        SchemeName=u.SchemeName,
                                        SchemeType=u.SchemeType,
                                        SchemeVersion=u.SchemeVersion,
                                        Sort=u.Sort,
                                        Status=u.Status,
                                        Content=b.Content,
                                        ContentData=b.ContentData,
                                        ContentParse=b.ContentParse,
                                        Fields=b.Fields                      
                                   })
                                 .ToPagedListAsync(input.PageNo, input.PageSize);
        return entities.XnPagedResult();
    }

    /// <summary>
    /// 增加流程管理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowscheme/add")]
    public async Task Add(AddFlcFlowschemeInput input)
    {
        var isExist = await _rep.AnyAsync(u => u.SchemeName == input.SchemeName);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);
        var formEntity = await _flcFormService.GetForm(new QueryFlcFormInput { Id = input.FrmId });
			if (formEntity == null)
            throw Oops.Oh(ErrorCode.F1000);
        input.Status = CommonStatus.DISABLE;
        var entity = input.Adapt<FlcFlowscheme>();
        entity.FrmType = formEntity.FrmType;
        await _rep.InsertAsync(entity);
    }

    /// <summary>
    /// 删除流程管理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowscheme/delete")]
    public async Task Delete(DeleteFlcFlowschemeInput input)
    {
        var flow = await _rep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));

        // 检测数据范围能不能操作这个表单
        (flow.CreatedUserId ?? 0).CheckDataScope();
        //假删除
        await _rep.UpdateAsync(a => a.Id == long.Parse(input.Id),a => new FlcFlowscheme
        {
            Status = CommonStatus.DELETED,
            IsDeleted = true,
        });
    }

    /// <summary>
    /// 更新流程管理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowscheme/edit")]
    public async Task Update(UpdateFlcFlowschemeInput input)
    {
        if (input.Id != "0" && !string.IsNullOrEmpty(input.Id))
        {
            var org = await _rep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
            _ = org ?? throw Oops.Oh(ErrorCode.D2000);
        }

        var flcFlow = await _rep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));

        // 检测数据范围能不能操作这个表单
        (flcFlow.CreatedUserId ?? 0).CheckDataScope();

        var isExist = await _rep.AnyAsync(u => (u.SchemeName == input.SchemeName) && u.Id != flcFlow.Id);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);
        var entity = input.Adapt<FlcFlowscheme>();
        var formEntity = await _flcFormService.GetForm(new QueryFlcFormInput { Id = flcFlow.FrmId.ToString() });
        if (formEntity == null)
            throw Oops.Oh(ErrorCode.F1000);
        entity.FrmType=formEntity.FrmType;
        await _rep.AsUpdateable(entity).IgnoreColumns(ignoreAllNullColumns:true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取流程管理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowscheme/detail")]
    public async Task<FlcFlowschemeOutput> Get([FromQuery] DeleteFlcFlowschemeInput input)
    {
        var cachedata = await _rep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
        var temp = cachedata.Adapt<FlcFlowschemeOutput>();
        var form = await _rep.Change<FlcForm>().AsQueryable().InSingleAsync(cachedata.FrmId);
        temp.WebId = form.WebId;
        temp.ContentData = form.ContentData;
        temp.Content = form.Content;
        //创建运行实例
        var flowinstance = new FlcFlowinstance();
        flowinstance.SchemeContent = temp.SchemeContent;
			if (flowinstance.SchemeContent.IsEmpty())
			{
            return temp;
			}
        var runtime = new FlowRuntime(flowinstance);
        if (runtime.nextNodeType != -1 && runtime.nextNode != null && runtime.nextNode.setInfo != null && runtime.nextNodeType != 4)
        {
            temp.NextNodeDesignateType = runtime.nextNode.setInfo.NodeDesignate;
            if (temp.NextNodeDesignateType == Setinfo.SPECIAL_USER)
            {
                temp.NextNodeDesignates = runtime.nextNode.setInfo.NodeDesignateData.ToArray();
                temp.NextMakerName = string.Join(',', _rep.Change<SysUser>().Where(a => temp.NextNodeDesignates.Contains(a.Id.ToString())).Select(a => a.Name).ToList());
            }
            else if (temp.NextNodeDesignateType == Setinfo.SPECIAL_ROLE)
            {
                temp.NextNodeDesignates = runtime.nextNode.setInfo.NodeDesignateData.ToArray();
                List<SysUser> list = new List<SysUser>();
                List<long> users = new List<long>();
                foreach (var item in temp.NextNodeDesignates)
                {
                    var usertemp = _rep.Change<SysUser>().AsQueryable().LeftJoin<SysUserRole>((a, b) => a.Id == b.SysUserId && b.SysRoleId == long.Parse(item)).Select((a, b) => a).Distinct().ToList();
                    var tempList = new List<SysUser>();
                    if (runtime.nextNode.setInfo.CurrentDepart)
                    {
                        var currentDepartment = new List<long>();
                        var empInfo = await _sysEmpService.GetEmpInfo(UserManager.UserId);
                        if (empInfo != null)
                        {
                            currentDepartment.Add(long.Parse(empInfo.OrgId));
                            if (empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)
                                currentDepartment.AddRange(empInfo.ExtOrgPos.Select(a => a.OrgId));
                        }
                        foreach (var user in usertemp)
                        {
                            var nextCurrentDepartment = new List<long>();
                            var empTempInfo = await _sysEmpService.GetEmpInfo(UserManager.UserId);
                            if (empTempInfo != null)
                            {
                                nextCurrentDepartment.Add(long.Parse(empTempInfo.OrgId));
                                if (empInfo.ExtOrgPos != null && empTempInfo.ExtOrgPos.Count > 0)
                                    nextCurrentDepartment.AddRange(empTempInfo.ExtOrgPos.Select(a => a.OrgId));
                            }
                            if (JsonUtil.IsArrayIntersection(currentDepartment, nextCurrentDepartment))
                            {
                                tempList.Add(user);
                            }
                        }
                    }
                    else
                    {
                        tempList = usertemp;
                    }
                    var tempFinal = tempList.Select(a => a.Id).ToList();
                    users.AddRange(tempFinal);
                }
                users = users.Distinct().ToList();
                temp.NextMakerName = string.Join(',', _rep.Change<SysUser>().Where(a => users.Contains(a.Id)).Select(a => a.Name).ToList());
            }
        }
        return temp;
    }

    /// <summary>
    /// 获取流程管理列表
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowscheme/list")]
    public async Task<List<FlcFlowschemeOutput>> List([FromQuery] FlcFlowschemeInput input)
    {
        var dataScopeList = await DataFilterExtensions.GetDataScopeIdList(FilterType.Org);
        var flows = await _rep.AsQueryable()
                            .LeftJoin<FlcForm>((u, b) => u.FrmId == b.Id)
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.OrgId), u => u.OrgId == long.Parse(input.OrgId) || u.OrgId == null || u.OrgId == 0)
                                   .WhereIF(dataScopeList.Any(), u => dataScopeList.Contains(u.OrgId ?? 0))
                                   .Where(u => u.Status != CommonStatus.DELETED)
                                   .OrderBy(u => u.Sort)
                                    .Select<FlcFlowschemeOutput>((u, b) => new FlcFlowschemeOutput
                                    {
                                        Id = u.Id.ToString(),
                                        Active = u.Active,
                                        AuthorizeType = u.AuthorizeType,
                                        FrmId = u.FrmId.ToString(),
                                        FrmType = u.FrmType,
                                        OrgId = u.OrgId.ToString(),
                                        Name = b.Name,
                                        WebId=b.WebId,
                                        Remark = u.Remark,
                                        SchemeCanUser = u.SchemeCanUser,
                                        SchemeCode = u.SchemeCode,
                                        SchemeContent = u.SchemeContent,
                                        SchemeName = u.SchemeName,
                                        SchemeType = u.SchemeType,
                                        SchemeVersion = u.SchemeVersion,
                                        Sort = u.Sort,
                                        Status = u.Status,
                                        Content = b.Content,
                                        ContentData = b.ContentData,
                                        ContentParse = b.ContentParse,
                                        Fields = b.Fields
                                    })
                                   .ToListAsync();
        return flows;
    }
}
