

using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 系统应用服务
/// </summary>
[ApiDescriptionSettings(Name = "App", Order = 100)]
public class SysAppService : ISysAppService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysApp> _sysAppRep;    // 应用表仓储
    private readonly ISysMenuService _sysMenuService;

    public SysAppService(SqlSugarRepository<SysApp> sysAppRep,
                         ISysMenuService sysMenuService)
    {
        _sysAppRep = sysAppRep;
        _sysMenuService = sysMenuService;
    }

    /// <summary>
    /// 获取用户应用相关信息
    /// </summary>
    /// <param name="userId"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<dynamic> GetLoginApps(long userId)
    {
        var apps = _sysAppRep.Where(u => u.Status == (int)CommonStatus.ENABLE);
        if (!UserManager.IsSuperAdmin)
        {
            var appCodeList = await _sysMenuService.GetUserMenuAppCodeList(userId);
            apps = apps.Where(u => appCodeList.Contains(u.Code));
        }
        var appList = await apps.OrderBy(u => u.Active, OrderByType.Desc).OrderBy(u => u.Sort).Select(u => new AppOutput
        {
            Code = u.Code,
            Name = u.Name,
            Active = u.Active
        }).ToListAsync();  

        return appList;
    }

    /// <summary>
    /// 分页查询系统应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysApp/page")]
    public async Task<dynamic> QueryAppPageList([FromQuery] AppInput input)
    {
        var apps = await _sysAppRep.AsQueryable()
             .WhereIF(!string.IsNullOrWhiteSpace(input.Name), m => m.Name.Contains(input.Name.Trim()))
              .WhereIF(!string.IsNullOrWhiteSpace(input.Code), m => m.Code.Contains(input.Code))
              .ToPagedListAsync(input.PageNo, input.PageSize);
        return apps.XnPagedResult();
    }

    /// <summary>
    /// 增加系统应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysApp/add")]
    public async Task AddApp(AddAppInput input)
    {
        var isExist = await _sysAppRep.AnyAsync(u => u.Name == input.Name || u.Code == input.Code);
        if (isExist)
            throw Oops.Oh(ErrorCode.D5000);

        if (input.Active == YesOrNot.Y.ToString())
        {
            isExist = await _sysAppRep.AnyAsync(u => u.Active == input.Active);
            if (isExist)
                throw Oops.Oh(ErrorCode.D5001);
        }

        var app = input.Adapt<SysApp>();
        await _sysAppRep.InsertAsync(app);
    }

    /// <summary>
    /// 删除系统应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysApp/delete")]
    public async Task DeleteApp(DeleteAppInput input)
    {
        var app = await _sysAppRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        // 该应用下是否有状态为正常的菜单
        var hasMenu = await _sysMenuService.HasMenu(app.Code);
        if (hasMenu)
            throw Oops.Oh(ErrorCode.D5002);

        await _sysAppRep.DeleteAsync(app);
    }

    /// <summary>
    /// 更新系统应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysApp/edit")]
    public async Task UpdateApp(UpdateAppInput input)
    {
        var isExist = await _sysAppRep.AnyAsync(u => (u.Name == input.Name || u.Code == input.Code) && u.Id != input.Id);
        if (isExist)
            throw Oops.Oh(ErrorCode.D5000);

        if (input.Active == YesOrNot.Y.ToString())
        {
            isExist = await _sysAppRep.AnyAsync(u => u.Active == input.Active && u.Id!=input.Id);
            if (isExist)
                throw Oops.Oh(ErrorCode.D5001);
        }

        var app = input.Adapt<SysApp>();
        await _sysAppRep.AsUpdateable(app).IgnoreColumns(it => new { it.Status }).ExecuteCommandAsync();
    }

    /// <summary>
    /// 获取系统应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysApp/detail")]
    public async Task<SysApp> GetApp([FromQuery] QueryAppInput input)
    {
        return await _sysAppRep.FirstOrDefaultAsync(u => u.Id == input.Id);
    }

    /// <summary>
    /// 获取系统应用列表
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysApp/list")]
    public async Task<dynamic> GetAppList([FromQuery] AppInput input)
    {
        return await _sysAppRep.Where(u => u.Status == (int)CommonStatus.ENABLE).ToListAsync();
    }

    /// <summary>
    /// 设为默认应用
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysApp/setAsDefault")]
    public async Task SetAsDefault(SetDefaultAppInput input)
    {
        var apps = await _sysAppRep.Where(u => u.Status == (int)CommonStatus.ENABLE).ToListAsync();
        apps.ForEach(u =>
        {
            if (u.Id == input.Id)
            {
                u.Active = YesOrNot.Y.ToString();
            }
            else {
                u.Active = YesOrNot.N.ToString();
            }
        });
        await _sysAppRep.UpdateAsync(apps);
    }

    /// <summary>
    /// 修改用户状态
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysApp/changeStatus")]
    public async Task ChangeUserAppStatus(UpdateAppInput input)
    {
        if (!Enum.IsDefined(typeof(CommonStatus), input.Status))
            throw Oops.Oh(ErrorCode.D3005);

        var app = await _sysAppRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        app.Status = input.Status;
        await _sysAppRep.UpdateAsync(app);
    }
}
