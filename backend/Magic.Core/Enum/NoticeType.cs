using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core;

public enum NoticeType
{
    /// <summary>
    /// 通知
    /// </summary>
    [Description("通知")]
    NOTICE = 1,

    /// <summary>
    /// 公告
    /// </summary>
    [Description("公告")]
    ANNOUNCEMENT = 2,

}
