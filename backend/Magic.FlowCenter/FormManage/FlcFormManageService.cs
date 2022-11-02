using Furion;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core;
using Magic.FlowCenter.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Threading.Tasks;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 表单管理
/// </summary>
[ApiDescriptionSettings("FlowCenter", Name = "FormManage", Order = 100)]
public class FlcFormManageService : IFlcFormManageService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<FlcForm> _flcFormRep;

		public FlcFormManageService(SqlSugarRepository<FlcForm> flcFormRep)
    {
        _flcFormRep = flcFormRep;
    }

    /// <summary>
    /// 分页查询表单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcForm/page")]
    public async Task<dynamic> QueryFormPageList([FromQuery] PageFlcFormInput input)
    {
        var orgs = await _flcFormRep.AsQueryable()
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.Id), u => u.Id == long.Parse(input.Id.Trim()))
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.OrgId), u => u.OrgId == long.Parse(input.OrgId) || u.OrgId == null || u.OrgId == 0)
                                   .Where(u => u.Status != CommonStatus.DELETED)
                                   .OrderBy(u => u.Sort)
                                   .Select<FlcFormOutput>()
                                   .ToPagedListAsync(input.PageNo, input.PageSize);
        return orgs.XnPagedResult();
    }

    /// <summary>
    /// 获取表单列表
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcForm/list")]
    public async Task<List<FlcFormOutput>> GetFormList([FromQuery] FlcFormInput input)
    {
        var dataScopeList = await DataFilterExtensions.GetDataScopeIdList(FilterType.Org);
        var forms = await _flcFormRep.AsQueryable()
                                   .WhereIF(!string.IsNullOrWhiteSpace(input.OrgId), u => u.OrgId == long.Parse(input.OrgId) || u.OrgId == null || u.OrgId == 0)
                                   .WhereIF(dataScopeList.Any(), u => dataScopeList.Contains(u.OrgId??0)|| u.OrgId == null || u.OrgId == 0)
                                   .Where(u => u.Status == CommonStatus.ENABLE)
                                   .OrderBy(u => u.Sort)
                                   .ToListAsync();
        return forms.Adapt<List<FlcFormOutput>>();
    }

    /// <summary>
    /// 增加表单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcForm/add")]
    public async Task AddForm(AddFlcFormInput input)
    {
        var isExist = await _flcFormRep.AnyAsync(u => u.Name == input.Name);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);

        var flcForm = input.Adapt<FlcForm>();
        flcForm.Status = CommonStatus.ENABLE;
        //反射获取这个表单的所有参数和备注，排除主键
        if (flcForm.FrmType == FormType.CUSTOMFORM)
			{
            var dataname = input.WebId.Substring(0, 1).ToUpper() + input.WebId.Substring(1);
            var t = App.Assemblies
                 .SelectMany(a => a.GetTypes().Where(t => t.FullName.Contains("Magic.FlowCenter.Entity") && t.FullName.Contains("." + dataname))).First();
            List<string> list = new List<string>();
            List<object> parses = new List<object>();
            dynamic obj = Activator.CreateInstance(t);
            foreach (PropertyInfo info in obj.GetType().GetProperties())
            {
                if (info.Name != "Id")
                {
                    list.Add(info.Name);
                    parses.Add(new { id = info.Name, name = info.Name });
                }
            }
            flcForm.ContentData = string.Join(',', list);
            flcForm.Fields = list.Count();
            flcForm.ContentParse = parses.ToJsonString();
        }
        await _flcFormRep.InsertAsync(flcForm);
    }

    /// <summary>
    /// 删除表单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcForm/delete")]
    public async Task DeleteForm(DeleteFlcFormInput input)
    {
        var flcForm = await _flcFormRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));

        (flcForm.CreatedUserId ?? 0).CheckDataScope();
        //假删除
        await _flcFormRep.Change<FlcForm>().UpdateAsync(u => u.Id == long.Parse(input.Id),a => new FlcForm
        {
            Status = CommonStatus.DELETED,
            IsDeleted = true,
        });
    }

    /// <summary>
    /// 更新表单
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/flcForm/edit")]
    public async Task UpdateForm(UpdateFlcFormInput input)
    {
        if (input.Id != "0" && !string.IsNullOrEmpty(input.Id))
        {
            var org = await _flcFormRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
            _ = org ?? throw Oops.Oh(ErrorCode.D2000);
        }

        var flcForm = await _flcFormRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
        // 检测数据范围能不能操作这个表单
        (flcForm.CreatedUserId ?? 0).CheckDataScope();

        var isExist = await _flcFormRep.AnyAsync(u => (u.Name == input.Name) && u.Id != flcForm.Id);
        if (isExist)
            throw Oops.Oh(ErrorCode.D2002);
        flcForm = input.Adapt<FlcForm>();
        //反射获取这个表单的所有参数和备注，排除主键
        if (flcForm.FrmType == FormType.CUSTOMFORM)
        {
            var dataname = input.WebId.Substring(0, 1).ToUpper() + input.WebId.Substring(1);
            var t = App.Assemblies
                 .SelectMany(a => a.GetTypes().Where(t => t.FullName.Contains("Magic.FlowCenter.Entity") && t.FullName.Contains("." + dataname))).First();
            List<string> list = new List<string>();
            List<object> parses = new List<object>();
            dynamic obj = Activator.CreateInstance(t);
            foreach (PropertyInfo info in obj.GetType().GetProperties())
            {
                if (info.Name != "Id")
                {
                    list.Add(info.Name);
                    parses.Add(new { id = info.Name, name = info.Name });
                }
            }
            flcForm.ContentData = string.Join(',', list);
            flcForm.Fields = list.Count();
            flcForm.ContentParse = parses.ToJsonString();
        }
        await _flcFormRep.AsUpdateable(flcForm).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取表单信息
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/flcForm/detail")]
    public async Task<FlcForm> GetForm([FromQuery] QueryFlcFormInput input)
    {
        return await _flcFormRep.FirstOrDefaultAsync(u => u.Id == long.Parse(input.Id));
    }
}
