using System.ComponentModel;

namespace Magic.Core;

/// <summary>
/// 账号类型
/// </summary>
public enum RoleType
{
    /// <summary>
    /// 租户管理员角色
    /// </summary>
    [Description("租户管理员角色")]
    AdminRole = 1,

    /// <summary>
    /// 租户普通角色
    /// </summary>
    [Description("租户普通角色")]
    NormalRole = 0,

}
