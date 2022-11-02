using System.ComponentModel;

namespace Magic.Core;

public enum TenantTypeEnum
{
    [Description("普通租户")]
    COMMON = 0,

    [Description("系统租户")]
    SYSTEM = 1,
}
