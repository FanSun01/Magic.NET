using Furion;
using Furion.DataEncryption;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.EventBus;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using UAParser;

namespace Magic.Core.Service;

/// <summary>
/// 登录授权相关服务
/// </summary>
[ApiDescriptionSettings(Name = "Auth", Order = 160)]
public class AuthService : IAuthService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysUser> _sysUserRep; // 用户表仓储  
    private readonly SqlSugarRepository<SysLogVis> _sysLogVisRep;
    private readonly SqlSugarRepository<SysTenant> _sysTenantRep;

    private readonly IHttpContextAccessor _httpContextAccessor;
    private readonly ISysEmpService _sysEmpService; // 系统员工服务      
    private readonly ISysRoleService _sysRoleService; // 系统角色服务  
    private readonly ISysMenuService _sysMenuService; // 系统菜单服务
    private readonly ISysAppService _sysAppService; // 系统应用服务
    private readonly IClickWordCaptcha _captchaHandle; // 验证码服务
    private readonly ISysConfigService _sysConfigService; // 验证码服务
    private readonly IEventPublisher _eventPublisher;


    public AuthService(SqlSugarRepository<SysUser> sysUserRep, SqlSugarRepository<SysLogVis> sysLogVisRep, SqlSugarRepository<SysTenant> sysTenantRep,
        IHttpContextAccessor httpContextAccessor,
        ISysEmpService sysEmpService, ISysRoleService sysRoleService, ISysMenuService sysMenuService,
        ISysAppService sysAppService, IClickWordCaptcha captchaHandle, ISysConfigService sysConfigService,
        IEventPublisher eventPublisher
        )
    {
        _sysUserRep = sysUserRep;
        _sysLogVisRep = sysLogVisRep;
        _sysTenantRep=sysTenantRep;
        _httpContextAccessor = httpContextAccessor;
        _sysEmpService = sysEmpService;
        _sysRoleService = sysRoleService;
        _sysMenuService = sysMenuService;
        _sysAppService = sysAppService;
        _captchaHandle = captchaHandle;
        _sysConfigService = sysConfigService;
        _eventPublisher = eventPublisher;
    }

    /// <summary>
    /// 用户登录
    /// </summary>
    /// <param name="input"></param>
    /// <remarks>默认用户名/密码：admin/admin</remarks>
    /// <returns></returns>
    [HttpPost("/login")]
    [AllowAnonymous]
    public async Task<string> LoginAsync([Required] LoginInput input)
    {
        // 获取加密后的密码
        var encryptPassword = MD5Encryption.Encrypt(input.Password);

        // 判断用户名和密码是否正确(排除全局多租户过滤器)Filter(null,true)
        var user = _sysUserRep.AsQueryable().Filter(null, true)
            .WhereIF(input.TenantId.HasValue && input.TenantId.Value > 0, m => m.TenantId == input.TenantId).First(u =>
                u.Account.Equals(input.Account) && u.Password.Equals(encryptPassword) && !u.IsDeleted);
        _ = user ?? throw Oops.Oh(ErrorCode.D1000);

        // 验证账号是否被冻结
        if (user.Status == CommonStatus.DISABLE)
            throw Oops.Oh(ErrorCode.D1017);
        //获取对应租户
        var tenant = _sysTenantRep.Single(user.TenantId);
        // 生成Token令牌
        //var accessToken = await _jwtBearerManager.CreateTokenAdmin(user);
        var accessToken = JWTEncryption.Encrypt(new Dictionary<string, object>
        {
            {ClaimConst.CLAINM_USERID, user.Id},
            {ClaimConst.TENANT_ID, user.TenantId},
            {ClaimConst.CLAINM_ACCOUNT, user.Account},
            {ClaimConst.CLAINM_NAME, user.Name},
            {ClaimConst.CLAINM_SUPERADMIN, user.AdminType},
            { ClaimConst.CLAINM_TENANT_TYPE, tenant.TenantType },
            { ClaimConst.CLAINM_TENANT_NAME, tenant.Name },
        });

        // 设置Swagger自动登录
        _httpContextAccessor.HttpContext.SigninToSwagger(accessToken);

        // 生成刷新Token令牌
        var refreshToken = JWTEncryption.GenerateRefreshToken(accessToken, 30);

        // 设置刷新Token令牌
        _httpContextAccessor.HttpContext.Response.Headers["x-access-token"] = refreshToken;

        var httpContext = App.HttpContext;
        await _eventPublisher.PublishAsync(new ChannelEventSource("Update:UserLoginInfo",
            new SysUser {Id = user.Id, LastLoginIp = httpContext.GetLocalIpAddressToIPv4(), LastLoginTime = DateTime.Now}));
        return accessToken;
    }

    /// <summary>
    /// 模拟租户登录
    /// </summary>
    /// <param name="input"></param>
    /// <remarks>默认用户名/密码：admin/admin</remarks>
    /// <returns></returns>
    [HttpPost("/simulationTenantLogin")]
    public async Task<string> SimulationLoginAsync([Required] LoginInput input)
    {
        SysTenant tenant = null;
        if (input.TenantId.HasValue && input.TenantId.Value > 0)
        {
            tenant = _sysTenantRep.Single(input.TenantId.Value);
            if (tenant == null || (tenant.IsDeleted && tenant.TenantType != TenantTypeEnum.SYSTEM))
                throw Oops.Oh("租户不存在");
        }
        // 判断用户名和密码是否正确(排除全局多租户过滤器)Filter(null,true)
        var user = _sysUserRep.AsQueryable().Filter(null, true)
            .Where(m => m.TenantId == input.TenantId)
            .First(u => u.Account.Equals(input.Account) && !u.IsDeleted);
        _ = user ?? throw Oops.Oh(ErrorCode.D1000);

        // 验证账号是否被冻结
        if (user.Status == CommonStatus.DISABLE)
            throw Oops.Oh(ErrorCode.D1017);

        // 生成Token令牌
        //var accessToken = await _jwtBearerManager.CreateTokenAdmin(user);
        var accessToken = JWTEncryption.Encrypt(new Dictionary<string, object>
        {
            { ClaimConst.CLAINM_USERID, user.Id },
            { ClaimConst.TENANT_ID, user.TenantId },
            { ClaimConst.CLAINM_ACCOUNT, user.Account },
            { ClaimConst.CLAINM_NAME, user.Name },
            { ClaimConst.CLAINM_SUPERADMIN, user.AdminType },
            { ClaimConst.CLAINM_TENANT_TYPE, tenant.TenantType },
            { ClaimConst.CLAINM_TENANT_NAME, tenant.Name },
        });

        // 设置Swagger自动登录
        _httpContextAccessor.HttpContext.SigninToSwagger(accessToken);

        // 生成刷新Token令牌
        var refreshToken = JWTEncryption.GenerateRefreshToken(accessToken, 30);

        // 设置刷新Token令牌
        _httpContextAccessor.HttpContext.Response.Headers["x-access-token"] = refreshToken;

        var httpContext = App.HttpContext;
        await _eventPublisher.PublishAsync(new ChannelEventSource("Update:UserLoginInfo",
             new SysUser { Id = user.Id, LastLoginIp = httpContext.GetLocalIpAddressToIPv4(), LastLoginTime = DateTime.Now }));
        return accessToken;
    }

    /// <summary>
    /// 获取当前登录用户信息
    /// </summary>
    /// <returns></returns>
    [HttpGet("getLoginUser")]
    public async Task<LoginOutput> GetLoginUserAsync()
    {
        var user = _sysUserRep.Single(UserManager.UserId);
        var userId = user.Id;

        var httpContext = App.GetService<IHttpContextAccessor>().HttpContext;
        var loginOutput = user.Adapt<LoginOutput>();

        loginOutput.LastLoginTime = user.LastLoginTime = DateTime.Now;
        var ip = HttpNewUtil.Ip;
        loginOutput.LastLoginIp = user.LastLoginIp =
            string.IsNullOrEmpty(user.LastLoginIp) ? HttpNewUtil.Ip : ip;

        var clent = Parser.GetDefault().Parse(httpContext.Request.Headers["User-Agent"]);
        loginOutput.LastLoginBrowser = clent.UA.Family + clent.UA.Major;
        loginOutput.LastLoginOs = clent.OS.Family + clent.OS.Major;

        // 员工信息
        loginOutput.LoginEmpInfo = await _sysEmpService.GetEmpInfo(userId);

        // 角色信息
        loginOutput.Roles = await _sysRoleService.GetUserRoleList(userId);

        // 权限信息
        loginOutput.Permissions = await _sysMenuService.GetLoginPermissionList(userId);

        // 数据范围信息(机构Id集合)
        loginOutput.DataScopes = await DataFilterExtensions.GetDataScopeIdList();

        // 具备应用信息（多系统，默认激活一个，可根据系统切换菜单）,返回的结果中第一个为激活的系统
        loginOutput.Apps = await _sysAppService.GetLoginApps(userId);

        // 菜单信息
        if (loginOutput.Apps.Count > 0)
        {
            var defaultActiveAppCode = loginOutput.Apps.FirstOrDefault().Code;
            loginOutput.Menus = await _sysMenuService.GetLoginMenusAntDesign(userId, "");
            loginOutput.Menus.ForEach(item => { item.Hidden = item.Application != defaultActiveAppCode; });
        }

        // 增加登录日志
        await _eventPublisher.PublishAsync(new ChannelEventSource("Create:VisLog",
            new SysLogVis
            {
                Name = user.Name,
                Success = YesOrNot.Y,
                Message = "登录成功",
                Ip = loginOutput.LastLoginIp,
                Browser = loginOutput.LastLoginBrowser,
                Os = loginOutput.LastLoginOs,
                VisType = LoginType.LOGIN,
                VisTime = loginOutput.LastLoginTime,
                Account = user.Name
            }));

        return loginOutput;
    }

    /// <summary>
    /// 退出
    /// </summary>
    /// <returns></returns>
    [HttpGet("logout")]
    public async Task LogoutAsync()
    {
        _httpContextAccessor.HttpContext.SignoutToSwagger();
        var ip = HttpNewUtil.Ip;
        var user = _sysUserRep.Single(UserManager.UserId);
        // 增加退出日志
        await _eventPublisher.PublishAsync(new ChannelEventSource("Create:VisLog",
            new SysLogVis
            {
                Name = user.Name,
                Success = YesOrNot.Y,
                Message = "退出成功",
                VisType = LoginType.LOGOUT,
                VisTime = DateTime.Now,
                Account = user.Account,
                Ip = ip
            }));

        await Task.CompletedTask;
    }

    /// <summary>
    /// 获取验证码开关
    /// </summary>
    /// <returns></returns>
    [HttpGet("getCaptchaOpen")]
    [AllowAnonymous]
    public async Task<bool> GetCaptchaOpen()
    {
        return await _sysConfigService.GetCaptchaOpenFlag();
    }

    /// <summary>
    /// 获取验证码（默认点选模式）
    /// </summary>
    /// <returns></returns>
    [HttpPost("captcha/get")]
    [AllowAnonymous]
    [NonUnify]
    public async Task<dynamic> GetCaptcha()
    {
        // 图片大小要与前端保持一致（坐标范围）
        return await Task.FromResult(_captchaHandle.CreateCaptchaImage(_captchaHandle.RandomCode(6), 310, 155));
    }

    /// <summary>
    /// 校验验证码
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("captcha/check")]
    [AllowAnonymous]
    [NonUnify]
    public async Task<dynamic> VerificationCode(ClickWordCaptchaInput input)
    {
        return await Task.FromResult(_captchaHandle.CheckCode(input));
    }
}
