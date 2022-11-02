using Furion;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 组织机构服务
/// </summary>
[ApiDescriptionSettings(Name = "Org", Order = 148)]
public class SysOrgService : ISysOrgService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysOrg> _sysOrgRep;  // 组织机构表仓储 
    private readonly SqlSugarRepository<SysUserDataScope> _sysUserDataScopeRep;  
    private readonly ISysCacheService _sysCacheService;
    private readonly ISysEmpService _sysEmpService;
    private readonly ISysEmpExtOrgPosService _sysEmpExtOrgPosService;

		public SysOrgService(SqlSugarRepository<SysOrg> sysOrgRep,
                         SqlSugarRepository<SysUserDataScope> sysUserDataScopeRep,
                         ISysCacheService sysCacheService,
                         ISysEmpService sysEmpService,
                         ISysEmpExtOrgPosService sysEmpExtOrgPosService)
    {
        _sysOrgRep = sysOrgRep;
        _sysUserDataScopeRep = sysUserDataScopeRep;
        _sysCacheService = sysCacheService;
        _sysEmpService = sysEmpService;
        _sysEmpExtOrgPosService = sysEmpExtOrgPosService;
		}

    /// <summary>
    /// 分页查询组织机构
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysOrg/page")]
    public async Task<dynamic> QueryOrgPageList([FromQuery] PageOrgInput input)
    {
        var dataScopeList = GetDataScopeList(await DataFilterExtensions.GetDataScopeIdList(FilterType.Org));
        var orgs = await _sysOrgRep.AsQueryable()
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Id), u => u.Id == long.Parse(input.Id.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Pid), u => u.Pids.Contains(input.Pid.Trim()) || u.Id == long.Parse(input.Pid.Trim()))
                                   .WhereIF(dataScopeList.Any(), u => dataScopeList.Contains(u.Id)) // 非管理员范围限制
                                   .Where(u => u.Status != CommonStatus.DELETED)
                                   .OrderBy(u => u.Sort)
                                   .Select<OrgOutput>()
                                   .ToPagedListAsync(input.PageNo, input.PageSize);
        return orgs.XnPagedResult();
    }

    /// <summary>
    /// (非管理员)获取当前用户数据范围（机构Id）
    /// </summary>
    /// <param name="dataScopes"></param>
    /// <returns></returns>
    private List<long> GetDataScopeList(List<long> dataScopes)
    {
        var dataScopeList = new List<long>();
        // 如果是超级管理员则获取所有组织机构，否则只获取其数据范围的机构数据
        if (!UserManager.IsSuperAdmin && !UserManager.IsTenantAdmin)
        {
            if (dataScopes.Count < 1)
                return dataScopeList;

            // 此处获取所有的上级节点，用于构造完整树
            dataScopes.ForEach(u =>
            {
                var sysOrg = _sysOrgRep.FirstOrDefault(c => c.Id == u);
                var parentAndChildIdListWithSelf = sysOrg.Pids.TrimEnd(',').Replace("[", "").Replace("]", "")
                                                              .Split(",").Select(u => long.Parse(u)).ToList();
                parentAndChildIdListWithSelf.Add(sysOrg.Id);
                dataScopeList.AddRange(parentAndChildIdListWithSelf);
            });
        }

        return dataScopeList;
    }

    /// <summary>
    /// 获取组织机构列表
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysOrg/list")]
    public async Task<List<OrgOutput>> GetOrgList([FromQuery] OrgInput input)
    {
        var dataScopeList = GetDataScopeList(await DataFilterExtensions.GetDataScopeIdList(FilterType.Org));
        var orgs = await _sysOrgRep.AsQueryable()
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Pid), u => u.Pid == long.Parse(input.Pid))
                                   .Where(u => u.Status != CommonStatus.DELETED)
                                   .WhereIF(dataScopeList.Any(), u => dataScopeList.Contains(u.Id)) // 非管理员范围限制
                                   .OrderBy(u => u.Sort)
                                   .ToListAsync();
        return orgs.Adapt<List<OrgOutput>>();
    }

    /// <summary>
    /// 增加组织机构
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysOrg/add")]
    public async Task AddOrg(AddOrgInput input)
    {
        var isExist = await _sysOrgRep.AnyAsync(u => u.Name == input.Name || u.Code == input.Code);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);
        if (!UserManager.IsSuperAdmin)
        {
            // 如果新增的机构父Id不是0，则进行数据权限校验
            if (input.Pid != "0" && !string.IsNullOrEmpty(input.Pid))
            {
                // 新增组织机构的父机构不在自己的数据范围内
                long.Parse(input.Pid).CheckDataScope(FilterType.Org);
            }
            else
                throw Oops.Oh(ErrorCode.D2006);
        }

        var sysOrg = input.Adapt<SysOrg>();
        await FillPids(sysOrg);
        var newOrg = await _sysOrgRep.InsertReturnEntityAsync(sysOrg);
        // 当前用户不是超级管理员时，将新增的公司加到用户的数据权限
        if (App.User.FindFirst(ClaimConst.CLAINM_SUPERADMIN)?.Value != ((int)AdminType.SuperAdmin).ToString())
        {
            var userId = App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value;
            await _sysUserDataScopeRep.InsertAsync(new SysUserDataScope
            {
                SysUserId = long.Parse(userId),
                SysOrgId = newOrg.Id
            });
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
            await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);
        }
    }

    /// <summary>
    /// 填充父Ids字段
    /// </summary>
    /// <param name="sysOrg"></param>
    /// <returns></returns>
    private async Task FillPids(SysOrg sysOrg)
    {
        if (sysOrg.Pid == 0L)
        {
            sysOrg.Pids = "[" + 0 + "],";
        }
        else
        {
            var t = await _sysOrgRep.FirstOrDefaultAsync(u => u.Id == sysOrg.Pid);
            sysOrg.Pids = t.Pids + "[" + t.Id + "],";
        }
    }

    /// <summary>
    /// 删除组织机构
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysOrg/delete")]
    public async Task DeleteOrg(DeleteOrgInput input)
    {
        var sysOrg = await _sysOrgRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));

        // 检测数据范围能不能操作这个机构
        long.Parse(input.Id).CheckDataScope(FilterType.Org);

        // 该机构下有员工，则不能删
        var hasOrgEmp = await _sysEmpService.HasOrgEmp(sysOrg.Id);
        if (hasOrgEmp)
            throw Oops.Oh(ErrorCode.D2004);

        // 该机构下面子机构若有员工，则不能删
        var orgIds = await _sysOrgRep.Where(u => u.Pids.Contains(input.Id)).Select(u => u.Id).ToListAsync();
        var emps = await _sysEmpService.HasOrgEmp(orgIds);
        if (emps.Count > 0)
            throw Oops.Oh(ErrorCode.D2004);

        // 该附属机构下若有员工，则不能删
        var hasExtOrgEmp = await _sysEmpExtOrgPosService.HasExtOrgEmp(sysOrg.Id);
        if (hasExtOrgEmp)
            throw Oops.Oh(ErrorCode.D2005);

        // 级联删除子节点
        var childIdList = await GetChildIdListWithSelfById(sysOrg.Id);

        try
        {
            _sysOrgRep.CurrentBeginTran();
         

            // 级联删除该机构及子机构对应的角色-数据范围关联信息
            await _sysOrgRep.Change<SysRoleDataScope>().DeleteAsync(u => childIdList.Contains(u.SysOrgId));

            // 级联删除该机构子机构对应的用户-数据范围关联信息
            await _sysOrgRep.Change<SysUserDataScope>().DeleteAsync(u => childIdList.Contains(u.SysOrgId));

            await _sysOrgRep.DeleteAsync(u => childIdList.Contains(u.Id));
            _sysOrgRep.CurrentCommitTran();
            
        }
        catch (System.Exception)
        {
            _sysOrgRep.CurrentRollbackTran();
            throw;
        }
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);

    }

    /// <summary>
    /// 更新组织机构
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysOrg/edit")]
    public async Task UpdateOrg(UpdateOrgInput input)
    {
        if (input.Pid != "0" && !string.IsNullOrEmpty(input.Pid))
        {
            var org = await _sysOrgRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Pid));
            _ = org ?? throw Oops.Oh(ErrorCode.D2000);
        }
        if (input.Id == input.Pid)
            throw Oops.Oh(ErrorCode.D2001);

        // 如果是编辑，父id不能为自己的子节点
        var childIdListById = await GetChildIdListWithSelfById(long.Parse(input.Id));
        if (childIdListById.Contains(long.Parse(input.Pid)))
            throw Oops.Oh(ErrorCode.D2001);

        var sysOrg = await _sysOrgRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));

        // 检测数据范围能不能操作这个机构
        sysOrg.Id.CheckDataScope(FilterType.Org);

        var isExist = await _sysOrgRep.AnyAsync(u => (u.Name == input.Name || u.Code == input.Code) && u.Id != sysOrg.Id);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);

        try
        {
            _sysOrgRep.CurrentBeginTran();
            // 如果名称有变化，则修改对应员工的机构相关信息
            if (!sysOrg.Name.Equals(input.Name))
                await _sysEmpService.UpdateEmpOrgInfo(sysOrg.Id, input.Name);
        
            var isChangePid = sysOrg.Pid.ToString() != input.Pid;
            var oldPids=sysOrg.Pids;

            sysOrg = input.Adapt<SysOrg>();
            await FillPids(sysOrg);

            //如果父级菜单有变化，则修改该机构所有子级的pids
            if (isChangePid) 
                await _sysOrgRep.UpdateAsync(m=>m.Pids.Contains(sysOrg.Id.ToString()),m=> new SysOrg { Pids = m.Pids.Replace(oldPids, sysOrg.Pids) });

            await _sysOrgRep.AsUpdateable(sysOrg).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
            
            _sysOrgRep.CurrentCommitTran();
           
        }
        catch (System.Exception)
        {
            _sysOrgRep.CurrentRollbackTran();
            throw;
        }
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_DATASCOPE);
        await _sysCacheService.DelByPatternAsync(CommonConst.CACHE_KEY_USERSDATASCOPE);

    }

    /// <summary>
    /// 获取组织机构信息
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysOrg/detail")]
    public async Task<SysOrg> GetOrg([FromQuery] QueryOrgInput input)
    {
        return await _sysOrgRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
    }

    /// <summary>
    /// 根据节点Id获取所有子节点Id集合，包含自己
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private async Task<List<long>> GetChildIdListWithSelfById(long id)
    {
        var childIdList = await _sysOrgRep
            .Where(u => u.Pids.Contains(id.ToString()))
            .Select(u => u.Id)
            .ToListAsync();
        childIdList.Add(id);
        return childIdList;
    }

    /// <summary>
    /// 获取组织机构树       
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysOrg/tree")]
    public async Task<dynamic> GetOrgTree([FromQuery] OrgInput input)
    {
        var dataScopeList = new List<long>();
        if (!UserManager.IsSuperAdmin && !UserManager.IsTenantAdmin)
        {
            var dataScopes = await DataFilterExtensions.GetDataScopeIdList(FilterType.Org);
            if (dataScopes.Count < 1)
                return dataScopeList;
            dataScopeList = GetDataScopeList(dataScopes);
        }
        var orgs = await _sysOrgRep.Where(dataScopeList.Any(), u => dataScopeList.Contains(u.Id))
                                                    .Where(u => u.Status == (int)CommonStatus.ENABLE).OrderBy(u => u.Sort)
                                                    .Select(u => new OrgTreeNode
                                                    {
                                                        Id = u.Id,
                                                        ParentId = u.Pid,
                                                        Title = u.Name,
                                                        Value = u.Id.ToString(),
                                                        Weight = u.Sort
                                                    }).ToListAsync();

        return new TreeBuildUtil<OrgTreeNode>().DoTreeBuild(orgs);
    }

    /// <summary>
    /// 根据数据范围类型获取当前用户的数据范围（机构Id）集合
    /// </summary>
    /// <param name="dataScopeType"></param>
    /// <param name="orgId"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<List<long>> GetDataScopeListByDataScopeType(int dataScopeType, long orgId)
    {
        var orgIdList = new List<long>();
        if (orgId < 0)
            return orgIdList;

        // 如果是范围类型是全部数据，则获取当前所有的组织架构Id
        if (dataScopeType == (int)DataScopeType.ALL)
        {
            orgIdList = await _sysOrgRep.Where(u => u.Status == (int)CommonStatus.ENABLE).Select(u => u.Id).ToListAsync();
        }
        // 如果范围类型是本部门及以下部门，则查询本节点和子节点集合，包含本节点
        else if (dataScopeType == (int)DataScopeType.DEPT_WITH_CHILD)
        {
            orgIdList = await GetChildIdListWithSelfById(orgId);
        }
        // 如果数据范围是本部门，不含子节点，则直接返回本部门
        else if (dataScopeType == (int)DataScopeType.DEPT)
        {
            orgIdList.Add(orgId);
        }
        return orgIdList;
    }

    /// <summary>
    /// 获取所有的机构组织Id集合
    /// </summary>
    /// <returns></returns>
    [NonAction]
    public async Task<List<long>> GetAllDataScopeIdList()
    {
        return await _sysOrgRep.AsQueryable().Select(u => u.Id).ToListAsync();
    }
	}
