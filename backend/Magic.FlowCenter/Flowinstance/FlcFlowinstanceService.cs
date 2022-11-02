using Furion;
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
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Http;
using System.Threading.Tasks;
using Yitter.IdGenerator;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 工作流服务
/// </summary>
[ApiDescriptionSettings("FlowCenter", Name = "Flowinstance", Order = 100)]
public class FlcFlowinstanceService : IFlcFlowinstanceService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<FlcFlowinstance> _rep;
    private readonly IHttpClientFactory _httpClientFactory;
    private readonly ISysEmpService _sysEmpService;
    public FlcFlowinstanceService(SqlSugarRepository<FlcFlowinstance> rep, IHttpClientFactory httpClientFactory, ISysEmpService sysEmpService)
    {
        _rep = rep;
        _httpClientFactory = httpClientFactory;
        _sysEmpService = sysEmpService;
    }

    /// <summary>
    /// 分页查询工作流
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowinstance/page")]
    public async Task<dynamic> Page([FromQuery] FlcFlowinstanceInput input)
    {
        var userId = UserManager.UserId;
        var query = _rep.AsQueryable()
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.Code), u => u.Code == input.Code)
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.CustomName), u => u.CustomName == input.CustomName)
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.ActivityId), u => u.ActivityId == input.ActivityId)
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.ActivityName), u => u.ActivityName == input.ActivityName)
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.PreviousId), u => u.PreviousId == input.PreviousId)
                                .Where(u => u.Status != CommonStatus.DELETED);
        if (input.LookType == 1)   //待办事项
        {
            query = query.Where(a => (a.MakerList == "1" || a.MakerList.Contains(userId.ToString())) && (a.IsFinish == 0 || a.IsFinish == 4) && a.ActivityType < 3);
        }
        else if (input.LookType == 2)  //已办事项（即我参与过的流程）
        {
            var instances = _rep.Change<FlcFlowInstanceOperationHistory>().Where(a => a.CreatedUserId == userId)
                .Select(a => a.InstanceId).Distinct().ToList();
            query = query.Where(a => instances.Contains(a.Id));
        }
        else  //我的流程
        {
            query = query.Where(a => a.CreatedUserId == userId);
        }
        var entities = await query.ToDataFilter().ToPagedListAsync(input.PageNo, input.PageSize);
        return entities.XnPagedResult();
    }

    /// <summary>
    /// 获取工作流
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<FlcFlowinstanceOutput> Get(long id)
    {
        var data = await _rep.FirstOrDefaultAsync(u => u.Id == id);
        var entity = data.Adapt<FlcFlowinstanceOutput>();
			if (!entity.DbName.IsEmpty())
			{
            entity.WebId = entity.DbName.Substring(0, 1).ToLower() + entity.DbName.Substring(1);
        }
        entity.hisList = await _rep.Change<FlcFlowInstanceOperationHistory>().Where(a => a.InstanceId == id).OrderBy(a => a.CreatedTime).ToListAsync();
        return entity;
    }

    /// <summary>
    /// 获取工作流列表
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>Verification
    [HttpGet("/flcFlowinstance/list")]
    public async Task<dynamic> List([FromQuery] FlcFlowinstanceInput input)
    {
        return await _rep.AsQueryable()
                    .WhereIF(!string.IsNullOrWhiteSpace(input.Code), u => u.Code == input.Code)
                    .WhereIF(!string.IsNullOrWhiteSpace(input.CustomName), u => u.CustomName == input.CustomName)
                    .WhereIF(!string.IsNullOrWhiteSpace(input.ActivityId), u => u.ActivityId == input.ActivityId)
                    .WhereIF(!string.IsNullOrWhiteSpace(input.ActivityName), u => u.ActivityName == input.ActivityName)
                    .WhereIF(!string.IsNullOrWhiteSpace(input.PreviousId), u => u.PreviousId == input.PreviousId)
                    .Where(u => u.Status != CommonStatus.DELETED)
                    .ToListAsync();
    }

    /// <summary>
    /// 获取历史
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowinstance/histories")]
    public async Task<List<FlcFlowInstanceOperationHistory>> QueryHistories([FromQuery] QueryeFlcFlowinstanceInput input)
    {
        return await _rep.Change<FlcFlowInstanceOperationHistory>().Where(u => u.InstanceId == input.Id).OrderBy(u => u.CreatedTime).ToListAsync();
    }
    /// <summary>
    /// 驳回
    /// 如果NodeRejectStep不为空，优先使用；否则按照NodeRejectType驳回
    /// </summary>
    /// <returns></returns>
    [NonAction]
    public async Task<bool> NodeReject(Verification reqest)
    {
        FlcFlowinstance flowInstance = await  _rep.FirstOrDefaultAsync(u => u.Id == reqest.FlowInstanceId);
        var flowCreator = flowInstance.CreatedUserId;

        FlowRuntime wfruntime = new FlowRuntime(flowInstance);

        string resnode = "";
        resnode = string.IsNullOrEmpty(reqest.NodeRejectStep) ? wfruntime.RejectNode(reqest.NodeRejectType) : reqest.NodeRejectStep;

        var tag = new Tag
        {
            Description = reqest.VerificationOpinion,
            Taged = (int)TagState.Reject,
            UserId = UserManager.UserId,
            UserName = UserManager.Name
        };

        wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
        flowInstance.IsFinish = 4;//4表示驳回（需要申请者重新提交表单）
        _rep.CurrentBeginTran();
        if (resnode != "")
        {
            wfruntime.RemoveNode(resnode);
            flowInstance.SchemeContent = wfruntime.ToSchemeObj().ToJsonString();
            flowInstance.ActivityId = resnode;
            var prruntime = new FlowRuntime(flowInstance);
            prruntime.MakeTagNode(prruntime.currentNodeId, tag);
            flowInstance.PreviousId = prruntime.previousId;
            flowInstance.ActivityType = prruntime.GetNodeType(resnode);
            flowInstance.ActivityName = prruntime.Nodes[resnode].name;
            if (resnode == wfruntime.startNodeId)
            {
                flowInstance.MakerList = flowInstance.CreatedUserId.ToString();
            }
            else
            {
                flowInstance.MakerList = _rep.Change<FlcFlowInstanceTransitionHistory>().Where(a => a.FromNodeId == resnode && a.ToNodeId == prruntime.nextNodeId).OrderBy(a => a.CreatedTime, OrderByType.Desc).Select(a => a.CreatedUserId).First().ToString();//当前节点可执行的人信息
                flowInstance.MakerList = flowInstance.MakerList == "1" ? null : flowInstance.MakerList;
            }
            await AddRejectTransHistory(wfruntime, prruntime);
            await _rep.UpdateAsync(flowInstance);
        }
        await _rep.Change<FlcFlowInstanceOperationHistory>().InsertAsync(new FlcFlowInstanceOperationHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = reqest.FlowInstanceId,
            CreatedUserId = UserManager.UserId,
            CreatedUserName = UserManager.Name,
            CreatedTime = DateTime.Now,
            Content = "["
                      + wfruntime.currentNode.name
                      + "][" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "]驳回,备注："
                      + reqest.VerificationOpinion
        });
        _rep.CurrentCommitTran();

        wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);

        return true;
    }
    /// <summary>
    /// 节点审核
    /// </summary>
    /// <param name="request"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<bool> NodeVerification(Verification request)
    {
        var instanceId = request.FlowInstanceId;

        var tag = new Tag
        {
            UserName = UserManager.Name,
            UserId = UserManager.UserId,
            Description = request.VerificationOpinion,
            Taged = Int32.Parse(request.VerificationFinally)
        };
        FlcFlowinstance flowInstance = await _rep.FirstOrDefaultAsync(u => u.Id == instanceId);
        var flowCreator = flowInstance.CreatedUserId;
        FlcFlowInstanceOperationHistory flowInstanceOperationHistory = new FlcFlowInstanceOperationHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = instanceId,
            CreatedUserId = tag.UserId??0,
            CreatedUserName = tag.UserName,
            CreatedTime = DateTime.Now
        };//操作记录
        FlowRuntime wfruntime = new FlowRuntime(flowInstance);
        _rep.CurrentBeginTran();
        #region 会签
        if (flowInstance.ActivityType == 0)//当前节点是会签节点
        {
            //会签时的[当前节点]一直是会签开始节点
            //TODO: 标记会签节点的状态，这个地方感觉怪怪的
            wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);

            string canCheckId = ""; //寻找当前登录用户可审核的节点Id
            foreach (string fromForkStartNodeId in wfruntime.FromNodeLines[wfruntime.currentNodeId].Select(u => u.targetId))
            {
                var fromForkStartNode = wfruntime.Nodes[fromForkStartNodeId];  //与会前开始节点直接连接的节点
                canCheckId = await GetOneForkLineCanCheckNodeId(fromForkStartNode, wfruntime, tag, flowCreator??0);
                if (!string.IsNullOrEmpty(canCheckId)) break;
            }

            if (canCheckId == "")
            {
                throw Oops.Oh("审核异常,找不到审核节点");
            }

            flowInstanceOperationHistory.Content = "[" + wfruntime.Nodes[canCheckId].name
                                                       + "][" + DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                                                       + "]" + (tag.Taged == 1 ? "同意" : "不同意") + ",备注："
                                                       + tag.Description;

            wfruntime.MakeTagNode(canCheckId, tag); //标记审核节点状态
            string res = wfruntime.NodeConfluence(canCheckId, tag);
            if (res == TagState.No.ToString("D"))
            {
                flowInstance.IsFinish = 3;
            }
            else if (!string.IsNullOrEmpty(res))
            {
                flowInstance.PreviousId = flowInstance.ActivityId;
                flowInstance.ActivityId = wfruntime.nextNodeId;
                flowInstance.ActivityType = wfruntime.nextNodeType;
                flowInstance.ActivityName = wfruntime.nextNode.name;
                flowInstance.IsFinish = (wfruntime.nextNodeType == 4 ? 1 : 0);
                flowInstance.MakerList = wfruntime.nextNodeType == 4 ? "" : await GetNextMakers(wfruntime, request, flowCreator??0);
                await AddTransHistory(wfruntime);
            }
            else
            {
                //会签过程中，需要更新用户
                flowInstance.MakerList = await GetForkNodeMakers(wfruntime, wfruntime.currentNodeId, flowCreator??0);
                await AddTransHistory(wfruntime);
            }

        }
        #endregion 会签

        #region 一般审核
        else
        {
            wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
            if (tag.Taged == (int)TagState.Ok)
            {
                flowInstance.PreviousId = flowInstance.ActivityId;
                flowInstance.ActivityId = wfruntime.nextNodeId;
                flowInstance.ActivityType = wfruntime.nextNodeType;
                flowInstance.ActivityName = wfruntime.nextNode.name;
                flowInstance.MakerList = (wfruntime.GetNextNodeType() != 4 ? await GetNextMakers(wfruntime, request, flowCreator??0) : "");
                flowInstance.IsFinish = (wfruntime.nextNodeType == 4 ? 1 : 0);
                await AddTransHistory(wfruntime);
            }
            else
            {
                flowInstance.IsFinish = 3; //表示该节点不同意
            }
            flowInstanceOperationHistory.Content = "[" + wfruntime.currentNode.name
                                                       + "][" + DateTime.Now.ToString("yyyy-MM-dd HH:mm")
                                                       + "]" + (tag.Taged == 1 ? "同意" : "不同意") + ",备注："
                                                       + tag.Description;
        }
        #endregion 一般审核

        wfruntime.RemoveNode(wfruntime.nextNodeId);
        flowInstance.SchemeContent = wfruntime.ToSchemeObj().ToJsonString();
        await _rep.AsUpdateable(flowInstance).IgnoreColumns(ignoreAllNullColumns:true).ExecuteCommandAsync();
        await _rep.Change<FlcFlowInstanceOperationHistory>().InsertAsync(flowInstanceOperationHistory);
        _rep.CurrentCommitTran();
        //通知信息
        wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);
        return true;
    }
    //会签时，获取一条会签分支上面是否有用户可审核的节点
    [NonAction]
    private async Task<string> GetOneForkLineCanCheckNodeId(FlowNode fromForkStartNode, FlowRuntime wfruntime, Tag tag,long flowCreator)
    {
        string canCheckId = "";
        var node = fromForkStartNode;
        do  //沿一条分支线路执行，直到遇到会签结束节点
        {
            var makerList = await GetNodeMarkers(node, flowCreator);

            if (node.setInfo.Taged == null && !string.IsNullOrEmpty(makerList) && makerList.Split(',').Any(one => tag.UserId == long.Parse(one)))
            {
                canCheckId = node.id;
                break;
            }

            node = wfruntime.GetNextNode(node.id);
        } while (node.type != FlowNode.JOIN);

        return canCheckId;
    }
    /// <summary>
    /// 寻找下一步的执行人
    /// 一般用于本节点审核完成后，修改流程实例的当前执行人，可以做到通知等功能
    /// </summary>
    /// <returns></returns>
    [NonAction]
    private async Task<string> GetNextMakers(FlowRuntime wfruntime, NodeDesignate request, long flowCreator)
    {
        string makerList = "";
        if (wfruntime.nextNodeId == "-1")
        {
            throw Oops.Oh("无法寻找到下一个节点");
        }
        if (wfruntime.nextNodeType == 0)//如果是会签节点
        {
            makerList = await GetForkNodeMakers(wfruntime, wfruntime.nextNodeId, flowCreator);
        }
        else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE)
        { //如果是运行时指定角色
            if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
            {
                throw Oops.Oh("前端提交的节点权限类型异常，请检查流程");
            }
            var users = new List<string>();
            foreach (var item in request.NodeDesignates)
            {
                var temps = _rep.Change<SysUserRole>().Where(a => a.SysRoleId == long.Parse(item)).Select(a => a.SysUserId.ToString()).ToList();
                if (temps != null && temps.Count > 0)
                {
                    users.AddRange(temps);
                }
            }
            makerList = JsonUtil.ArrayToString(users.Distinct().ToList(), makerList);
        }
        else if (wfruntime.nextNode.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER)
        {  //如果是运行时指定用户
            if (wfruntime.nextNode.setInfo.NodeDesignate != request.NodeDesignateType)
            {
                throw Oops.Oh("前端提交的节点权限类型异常，请检查流程");
            }
            makerList = JsonUtil.ArrayToString(request.NodeDesignates, makerList);
        }
        else
        {
            makerList = await GetNodeMarkers(wfruntime.nextNode, flowCreator);
            if (string.IsNullOrEmpty(makerList))
            {
                throw (new Exception("无法寻找到节点的审核者,请查看流程设计是否有问题!"));
            }
        }

        return makerList;
    }

    /// <summary>
    /// 获取会签开始节点的所有可执行者
    /// </summary>
    /// <param name="wfruntime"></param>
    /// <param name="forkNodeId"></param>
    /// <param name="flowCreator"></param>
    /// <returns></returns>
    [NonAction]
    private async Task<string> GetForkNodeMakers(FlowRuntime wfruntime, string forkNodeId, long flowCreator)
    {
        string makerList = "";
        foreach (string fromForkStartNodeId in wfruntime.FromNodeLines[forkNodeId].Select(u => u.targetId))
        {
            var fromForkStartNode = wfruntime.Nodes[fromForkStartNodeId]; //与会前开始节点直接连接的节点
            if (makerList != "")
            {
                makerList += ",";
            }

            makerList += await GetOneForkLineMakers(fromForkStartNode, wfruntime, flowCreator);
        }

        return makerList;
    }

    //获取会签一条线上的审核者,该审核者应该是已审核过的节点的下一个人
    [NonAction]
    private async Task<string> GetOneForkLineMakers(FlowNode fromForkStartNode, FlowRuntime wfruntime,long flowCreator)
    {
        string markers = "";
        var node = fromForkStartNode;
        do  //沿一条分支线路执行，直到遇到第一个没有审核的节点
        {
            if (node.setInfo != null && node.setInfo.Taged != null)
            {
                if (node.type != FlowNode.FORK && node.setInfo.Taged != (int)TagState.Ok)  //如果节点是不同意或驳回，则不用再找了
                {
                    break;
                }
                node = wfruntime.GetNextNode(node.id);  //下一个节点
                continue;
            }
            var marker = await GetNodeMarkers(node, flowCreator);
            if (marker == "")
            {
                throw (new Exception($"节点{node.name}没有审核者,请检查!"));
            }
            if (marker == "1")
            {
                throw (new Exception($"节点{node.name}是会签节点，不能用所有人,请检查!"));
            }

            if (markers != "")
            {
                markers += ",";
            }
            markers += marker;
            break;
        } while (node.type != FlowNode.JOIN);

        return markers;
    }

    /// <summary>
    /// 寻找该节点执行人
    /// </summary>
    /// <param name="node"></param>
    /// <param name="flowCreator"></param>
    /// <returns></returns>
    [NonAction]
    private async Task<string> GetNodeMarkers(FlowNode node,long flowCreator)
    {
        string makerList = "";

        if (node.setInfo != null)
        {
            if (node.setInfo.NodeDesignate == Setinfo.ALL_USER)//所有成员
            {
                makerList = "1";
            }
            else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_USER)//指定成员
            {
                makerList = JsonUtil.ArrayToString(node.setInfo.NodeDesignateData, makerList);
            }
            else if (node.setInfo.NodeDesignate == Setinfo.SPECIAL_ROLE)  //指定角色
            {
                List<SysUser> list = new List<SysUser>();
                List <long> users = new List<long>();
                foreach (var item in node.setInfo.NodeDesignateData)
                {
                    var temp = _rep.Change<SysUser>().AsQueryable().InnerJoin<SysUserRole>((a,b)=>a.Id==b.SysUserId && b.SysRoleId == long.Parse(item)).Select((a,b)=>a).Distinct().ToList();
                    var tempList = new List<SysUser>();
                    if (node.setInfo.CurrentDepart)
                    {
                        var currentDepartment = new List<long>();
                        var empInfo=  await _sysEmpService.GetEmpInfo(flowCreator);
                        if (empInfo != null)
							{
                            currentDepartment.Add(long.Parse(empInfo.OrgId));
								if (empInfo.ExtOrgPos!=null&&empInfo.ExtOrgPos.Count>0)
                                currentDepartment.AddRange(empInfo.ExtOrgPos.Select(a=>a.OrgId));
                        }
                        foreach (var user in temp)
                        {
                            var nextCurrentDepartment = new List<long>();
                            var empTempInfo = await _sysEmpService.GetEmpInfo(user.Id);
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
                        tempList = temp;
                    }
                    var tempFinal = tempList.Select(a => a.Id).ToList();
                    users.AddRange(tempFinal);
                }
                users = users.Distinct().ToList();
                makerList = JsonUtil.ArrayToString(users, makerList);
            }
            else if (node.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_ROLE || node.setInfo.NodeDesignate == Setinfo.RUNTIME_SPECIAL_USER)
            {
                //如果是运行时选定的用户，则暂不处理。由上个节点审批时选定
            }
        }
        else  //如果没有设置节点信息，默认所有人都可以审核
        {
            makerList = "1";
        }
        return makerList;
    }

    /// <summary>
    /// 判定节点需要选择执行人或执行角色
    /// </summary>
    /// <param name="request"></param>
    /// <exception cref="Exception"></exception>
    [NonAction]
    private void CheckNodeDesignate(NodeDesignate request)
    {
        if ((request.NodeDesignateType == Setinfo.RUNTIME_SPECIAL_ROLE
             || request.NodeDesignateType == Setinfo.RUNTIME_SPECIAL_USER) && request.NodeDesignates.Length == 0)
        {
            throw Oops.Oh("下个节点需要选择执行人或执行角色");
        }
    }
    /// <summary>
    /// 返回用于处理流程节点
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcFlowinstance/detail")]
    public async Task<FlcFlowinstanceOutput> GetForVerification([FromQuery] QueryeFlcFlowinstanceInput input)
    {
        var flowinstance = await Get(input.Id);
        var runtime = new FlowRuntime(flowinstance);
        if (runtime.nextNodeType != -1 && runtime.nextNode != null && runtime.nextNode.setInfo != null && runtime.nextNodeType != 4)
        {
            flowinstance.NextNodeDesignateType = runtime.nextNode.setInfo.NodeDesignate;
            if (flowinstance.NextNodeDesignateType == Setinfo.SPECIAL_USER)
            {
                flowinstance.NextNodeDesignates = runtime.nextNode.setInfo.NodeDesignateData.ToArray();
                flowinstance.NextMakerName = string.Join(',', _rep.Change<SysUser>().Where(a => flowinstance.NextNodeDesignates.Contains(a.Id.ToString())).Select(a => a.Name).ToList());
            }
            else if (flowinstance.NextNodeDesignateType == Setinfo.SPECIAL_ROLE)
            {
                flowinstance.NextNodeDesignates = runtime.nextNode.setInfo.NodeDesignateData.ToArray();
                List<SysUser> list = new List<SysUser>();
                List<long> users = new List<long>();
                foreach (var item in flowinstance.NextNodeDesignates)
                {
                    var temp = _rep.Change<SysUser>().AsQueryable().InnerJoin<SysUserRole>((a, b) => a.Id == b.SysUserId && b.SysRoleId == long.Parse(item)).Select((a, b) => a).ToList();
                    var tempList = new List<SysUser>();
                    if (runtime.nextNode.setInfo.CurrentDepart)
                    {
                        var currentDepartment = new List<long>();
                        var empInfo = await _sysEmpService.GetEmpInfo(flowinstance.CreatedUserId??0);
                        if (empInfo != null)
                        {
                            currentDepartment.Add(long.Parse(empInfo.OrgId));
                            if (empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)
                                currentDepartment.AddRange(empInfo.ExtOrgPos.Select(a => a.OrgId));
                        }
                        foreach (var user in temp)
                        {
                            var nextCurrentDepartment = new List<long>();
                            var empTempInfo = await _sysEmpService.GetEmpInfo(user.Id);
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
                        tempList = temp;
                    }
                    var tempFinal = tempList.Select(a => a.Id).ToList();
                    users.AddRange(tempFinal);
                }
                users = users.Distinct().ToList();
                flowinstance.NextMakerName = string.Join(',', _rep.Change<SysUser>().Where(a => users.Contains(a.Id)).Select(a => a.Name).ToList());
            }
        }
        if (runtime.currentNode != null && runtime.currentNode.setInfo != null && runtime.currentNodeType != 4)
        {
            flowinstance.CurrentNodeDesignateType = runtime.currentNode.setInfo.NodeDesignate;
            if (flowinstance.MakerList != "1" && !string.IsNullOrEmpty(flowinstance.MakerList))
            {
                var temps = flowinstance.MakerList.Split(',');
                flowinstance.CurrentMakerName = string.Join(',', _rep.Change<SysUser>().Where(a => temps.Contains(a.Id.ToString())).Select(a => a.Name).ToList());
            }
            else
            {
                flowinstance.CurrentMakerName = "所有人";
            }
        }
        return flowinstance;
    }

    /// <summary>
    /// 添加扭转记录
    /// </summary>
    [NonAction]
    private async Task AddTransHistory(FlowRuntime wfruntime)
    {
        await _rep.Change<FlcFlowInstanceTransitionHistory>().InsertAsync(new FlcFlowInstanceTransitionHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = wfruntime.flowInstanceId,
            CreatedUserId = UserManager.UserId,
            CreatedTime = DateTime.Now,
            CreatedUserName = UserManager.Name,
            FromNodeId = wfruntime.currentNodeId,
            FromNodeName = wfruntime.currentNode.name,
            FromNodeType = wfruntime.currentNodeType,
            ToNodeId = wfruntime.nextNodeId,
            ToNodeName = wfruntime.nextNode.name,
            ToNodeType = wfruntime.nextNodeType,
            IsFinish = wfruntime.nextNodeType == 4 ? true : false,
            TransitionSate = false
        });
    }
    /// <summary>
    /// 添加扭转记录
    /// </summary>
    [NonAction]
    private async Task AddRejectTransHistory(FlowRuntime wfruntime, FlowRuntime prruntime)
    {
		await _rep.Change<FlcFlowInstanceTransitionHistory>().InsertAsync(new FlcFlowInstanceTransitionHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = wfruntime.flowInstanceId,
            CreatedUserId = UserManager.UserId,
            CreatedTime = DateTime.Now,
            CreatedUserName = UserManager.Name,
            FromNodeId = wfruntime.currentNodeId,
            FromNodeName = wfruntime.currentNode.name,
            FromNodeType = wfruntime.currentNodeType,
            ToNodeId = prruntime.currentNodeId,
            ToNodeName = prruntime.currentNode.name,
            ToNodeType = prruntime.currentNodeType,
            IsFinish = false,
            TransitionSate = false
        });
    }

    /// <summary>
    /// 节点处理
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowinstance/verification")]
    public async Task Verification(Verification input)
    {
        bool isReject = TagState.Reject.Equals((TagState)Int32.Parse(input.VerificationFinally));
        if (isReject)  //驳回
        {
            await NodeReject(input);
        }
        else
        {
            await NodeVerification(input);
        }
    }

    /// <summary>
    /// 新增流程实例
    /// </summary>
    /// <param name="entity"></param>
    /// <returns></returns>
    /// <exception cref="Exception"></exception>
    [HttpPost("/flcFlowinstance/add")]
    public async Task Add(FlcFlowinstance entity)
    {
        var nodeDesignate = new NodeDesignate();
        nodeDesignate.NodeDesignates = entity.NextNodeDesignates;
        nodeDesignate.NodeDesignateType = entity.NextNodeDesignateType;
        CheckNodeDesignate(nodeDesignate);
        FlcFlowscheme scheme = null;
        if (entity.SchemeId!=0)
        {
            scheme = await _rep.Change<FlcFlowscheme>().AsQueryable().InSingleAsync(entity.SchemeId);
        }
        if (scheme == null)
        {
            throw Oops.Oh("该流程模板已不存在，请重新设计流程");
        }
        entity.SchemeContent = scheme.SchemeContent;
        var form = await _rep.Change<FlcForm>().AsQueryable().InSingleAsync(scheme.FrmId);
        if (form == null)
        {
            throw Oops.Oh("该流程模板对应的表单已不存在，请重新设计流程");
        }
        entity.CustomName = scheme.SchemeName + DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss");
        var startTime = DateTime.Parse("1970-01-01");
        entity.Code = ((long)(DateTime.Now - startTime).TotalSeconds).ToString();
        entity.FrmContentData = form.ContentData;
        entity.FrmContent = form.Content;
        entity.FrmContentParse = form.ContentParse;
        entity.FrmType = form.FrmType;
        entity.FrmId = form.Id;
        entity.Status = CommonStatus.ENABLE;
        var flowCreator = entity.CreatedUserId;
        Dictionary<string, object> dic = JsonUtil.ToObject<Dictionary<string, object>>(entity.FrmData);
        if (!dic.ContainsKey("CreatedUserId"))
        {
            dic.Add("CreatedUserId", UserManager.UserId.ToString());

        }
        if (!dic.ContainsKey("CreatedOrgId"))
        {
            var currentDepartment = new List<long>();
            var empInfo = await _sysEmpService.GetEmpInfo(flowCreator??0);
            if (empInfo != null&& (empInfo.OrgId!=null ||(empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)))
            {
                currentDepartment.Add(long.Parse(empInfo.OrgId));
                if (empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)
                    currentDepartment.AddRange(empInfo.ExtOrgPos.Select(a => a.OrgId));
            }
            dic.Add("CreatedOrgId", String.Join(',', currentDepartment));
        }
        entity.FrmData = dic.ToJsonString();
        if(!form.WebId.IsEmpty())
			{
            entity.DbName = form.WebId.Substring(0, 1).ToUpper() + form.WebId.Substring(1);
        }
        entity.FlowLevel = 0;
        //创建运行实例
        var wfruntime = new FlowRuntime(entity);

        #region 根据运行实例改变当前节点状态
        entity.ActivityId = wfruntime.nextNodeId;
        entity.ActivityType = wfruntime.GetNextNodeType();
        entity.ActivityName = wfruntime.nextNode.name;
        entity.PreviousId = wfruntime.currentNodeId;
        entity.CreatedUserName = UserManager.Name;
        entity.MakerList = (wfruntime.GetNextNodeType() != 4 ? await GetNextMakers(wfruntime, nodeDesignate, flowCreator??0) : "");
        entity.IsFinish = (wfruntime.GetNextNodeType() == 4 ? 1 : 0);
        _rep.CurrentBeginTran();
        await _rep.InsertAsync(entity);

        wfruntime.flowInstanceId = entity.Id;
        //复杂表单提交
        if (entity.FrmType == FormType.CUSTOMFORM)
        {
            var t = App.Assemblies
                .SelectMany(a => a.GetTypes().Where(t => t.FullName.Contains("Magic.FlowCenter.") && t.FullName.Contains("." + entity.DbName + "Service"))).First();
            IFlcCustomFormService icf = (IFlcCustomFormService)App.GetService(t);
            await icf.Add(entity.Id, entity.FrmData);
        }

        #endregion

        #region 流程操作记录

        FlcFlowInstanceOperationHistory processOperationHistoryEntity = new FlcFlowInstanceOperationHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = entity.Id,
            CreatedUserId = entity.CreatedUserId??0,
            CreatedUserName = entity.CreatedUserName,
            CreatedTime = entity.CreatedTime,
            Content = "[创建]"
                      + entity.CreatedUserName
                      + "创建了一个流程["
                      + entity.Code + "/"
                      + entity.CustomName + "]"
        };
        await _rep.Change<FlcFlowInstanceOperationHistory>().InsertAsync(processOperationHistoryEntity);

        #endregion 流程操作记录

        await AddTransHistory(wfruntime);

        _rep.CurrentCommitTran();
    }

    /// <summary>
    /// 编辑流程实例
    /// </summary>
    /// <param name="entity"></param>
    /// <returns></returns>
    /// <exception cref="Exception"></exception>
    [HttpPost("/flcFlowinstance/edit")]
    public async Task Update(FlcFlowinstance entity)
    {
        var nodeDesignate = new NodeDesignate();
        nodeDesignate.NodeDesignates = entity.NextNodeDesignates;
        nodeDesignate.NodeDesignateType = entity.NextNodeDesignateType;
        CheckNodeDesignate(nodeDesignate);
        FlcFlowscheme scheme = null;
        if (entity.SchemeId != 0)
        {
            scheme = await _rep.Change<FlcFlowscheme>().AsQueryable().InSingleAsync(entity.SchemeId);
        }
        if (scheme == null)
        {
            throw Oops.Oh("该流程模板已不存在，请重新设计流程");
        }
        entity.SchemeContent = scheme.SchemeContent;
        var form = await _rep.Change<FlcForm>().AsQueryable().InSingleAsync(scheme.FrmId);
        if (form == null)
        {
            throw Oops.Oh("该流程模板对应的表单已不存在，请重新设计流程");
        }
        Dictionary<string, object> dic = JsonUtil.ToObject<Dictionary<string, object>>(entity.FrmData);
        if (!dic.ContainsKey("CreatedUserId"))
        {
            dic.Add("CreatedUserId", UserManager.UserId.ToString());

        }
        var flowCreator = UserManager.UserId;
        if (!dic.ContainsKey("CreatedOrgId"))
        {
            var currentDepartment = new List<long>();
            var empInfo = await _sysEmpService.GetEmpInfo(flowCreator);
            if (empInfo != null && (empInfo.OrgId != null || (empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)))
            {
                currentDepartment.Add(long.Parse(empInfo.OrgId));
                if (empInfo.ExtOrgPos != null && empInfo.ExtOrgPos.Count > 0)
                    currentDepartment.AddRange(empInfo.ExtOrgPos.Select(a => a.OrgId));
            }
            dic.Add("CreatedOrgId", String.Join(',', currentDepartment));
        }
        entity.FrmData = dic.ToJsonString();
        var wfruntime = new FlowRuntime(await _rep.FirstOrDefaultAsync(u => u.Id == entity.Id));
        entity.FrmContentData = form.ContentData;
        entity.FrmContentParse = form.ContentParse;
        entity.FrmType = form.FrmType;
        entity.FrmId = form.Id;
        if (!form.WebId.IsEmpty())
        {
            entity.DbName = form.WebId.Substring(0, 1).ToUpper() + form.WebId.Substring(1);
        }
        entity.FlowLevel = 0;
        //创建运行实例
        wfruntime = new FlowRuntime(entity);


        #region 根据运行实例改变当前节点状态
        entity.ActivityId = wfruntime.nextNodeId;
        entity.ActivityType = wfruntime.GetNextNodeType();
        entity.ActivityName = wfruntime.nextNode.name;
        entity.PreviousId = wfruntime.currentNodeId;
        entity.CreatedUserName = UserManager.Name;
        entity.MakerList = (wfruntime.GetNextNodeType() != 4 ? await GetNextMakers(wfruntime, nodeDesignate, flowCreator) : "");
        entity.IsFinish = (wfruntime.GetNextNodeType() == 4 ? 1 : 0);
        _rep.CurrentBeginTran();
        await _rep.AsUpdateable(entity)
           .IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
        wfruntime.flowInstanceId = entity.Id;
        //复杂表单提交
        if (entity.FrmType == FormType.CUSTOMFORM)
        {
            var t = App.Assemblies
                .SelectMany(a => a.GetTypes().Where(t => t.FullName.Contains("Magic.FlowCenter.") && t.FullName.Contains("." + entity.DbName + "Service"))).First();
            IFlcCustomFormService icf = (IFlcCustomFormService)App.GetService(t);
            await icf.Edit(entity.Id, entity.FrmData);

        }
        #endregion

        #region 流程操作记录
        FlcFlowInstanceOperationHistory processOperationHistoryEntity = new FlcFlowInstanceOperationHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = entity.Id,
            CreatedUserId = UserManager.UserId,
            CreatedUserName = entity.CreatedUserName,
            CreatedTime = DateTime.Now,
            Content = "[修改]"
                      + entity.CreatedUserName
                      + "修改了一个流程["
                      + entity.Code + "/"
                      + entity.CustomName + "]"
        };
		await _rep.Change<FlcFlowInstanceOperationHistory>().InsertAsync(processOperationHistoryEntity);
		#endregion

		await AddTransHistory(wfruntime);
        _rep.CurrentCommitTran();
    }
    /// <summary>
    /// 删除流程实例
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowinstance/delete")]
    public async Task Delete(DeleteFlcFlowinstanceInput input)
    {
        FlcFlowinstance flowInstance = await _rep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (flowInstance != null && flowInstance.IsFinish != 4 && flowInstance.IsFinish != 2) 
			{
            throw Oops.Oh("流程已在执行中，不能删除");
        }
        // 直接删除用户
        await _rep.AsUpdateable(new FlcFlowinstance { IsDeleted = true })
            .UpdateColumns(flowInstance.FalseDeleteColumn()).Where(wh => wh.Id == flowInstance.Id).ExecuteCommandAsync();
    }

    /// <summary>
    /// 撤销流程实例
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcFlowinstance/cancel")]
    public async Task Cancel(DeleteFlcFlowinstanceInput input)
    {
        FlcFlowinstance flowInstance = await _rep.FirstOrDefaultAsync(u => u.Id == input.Id);
        var flowCreator = flowInstance.CreatedUserId;
        FlowRuntime wfruntime = new FlowRuntime(flowInstance);

        string resnode = "";
        resnode = wfruntime.RejectNode("1");

        var tag = new Tag
        {
            Description = "流程撤回",
            Taged = (int)TagState.Reject,
            UserId = UserManager.UserId,
            UserName = UserManager.Name
        };

        wfruntime.MakeTagNode(wfruntime.currentNodeId, tag);
        flowInstance.IsFinish = 2;//2表示撤回（需要申请者重新提交表单）
        _rep.CurrentBeginTran();
        if (resnode != "")
        {
            wfruntime.RemoveNode(resnode);
            flowInstance.SchemeContent = wfruntime.ToSchemeObj().ToJsonString();
            flowInstance.ActivityId = resnode;
            var prruntime = new FlowRuntime(flowInstance);
            prruntime.MakeTagNode(prruntime.currentNodeId, tag);
            flowInstance.PreviousId = prruntime.previousId;
            flowInstance.ActivityType = prruntime.GetNodeType(resnode);
            flowInstance.ActivityName = prruntime.Nodes[resnode].name;
            if (resnode == wfruntime.startNodeId)
            {
                flowInstance.MakerList = flowInstance.CreatedUserId.ToString();
            }
            else
            {
                flowInstance.MakerList = _rep.Change<FlcFlowInstanceTransitionHistory>().Where(a => a.FromNodeId == resnode && a.ToNodeId == prruntime.nextNodeId).OrderBy(a => a.CreatedTime, OrderByType.Desc).Select(a => a.CreatedUserId).First().ToString();//当前节点可执行的人信息
                flowInstance.MakerList = flowInstance.MakerList == "1" ? null: flowInstance.MakerList;
            }
            await AddRejectTransHistory(wfruntime, prruntime);
            await _rep.UpdateAsync(flowInstance);
        }
		await _rep.Change<FlcFlowInstanceOperationHistory>().InsertAsync(new FlcFlowInstanceOperationHistory
        {
            Id = YitIdHelper.NextId(),
            InstanceId = input.Id,
            CreatedUserId = UserManager.UserId,
            CreatedUserName = UserManager.Name,
            CreatedTime = DateTime.Now,
            Content = "["
                      + wfruntime.currentNode.name
                      + "][" + DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "]撤回,备注：流程撤回"
        });
        _rep.CurrentCommitTran();
        wfruntime.NotifyThirdParty(_httpClientFactory.CreateClient(), tag);
    }
}
