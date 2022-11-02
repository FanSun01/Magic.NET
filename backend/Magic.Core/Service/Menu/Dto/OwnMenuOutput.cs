using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public class OwnMenuOutput
{
    /// <summary>
    /// 应用编码
    /// </summary>
    public string AppCode { get; set; }

    /// <summary>
    /// 菜单Id集合
    /// </summary>
    public List<long> MenuIdList { get; set; }
}
