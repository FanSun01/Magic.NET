using System.ComponentModel;

namespace Magic.Core;

	public enum FilterType
	{
    /// <summary>
    /// 用户
    /// </summary>
    [Description("用户")]
    User = 0,

    /// <summary>
    /// 组织
    /// </summary>
    [Description("组织")]
    Org = 1,
	}
