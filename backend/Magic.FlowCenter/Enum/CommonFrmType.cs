using System.ComponentModel;

namespace Magic.FlowCenter;

/// <summary>
/// 表单类型
/// </summary>
public enum FormType
{
    /// <summary>
    /// 正常
    /// </summary>
    [Description("动态表单")]
    DESIGNFORM = 0,

    /// <summary>
    /// 停用
    /// </summary>
    [Description("自定义表单")]
    CUSTOMFORM = 1,
}
