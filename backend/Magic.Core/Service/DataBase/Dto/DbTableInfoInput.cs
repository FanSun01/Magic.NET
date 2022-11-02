using System.Collections.Generic;

namespace Magic.Core.Service;

public class DbTableInfoInput
{
    public string Name
    {
        get;
        set;
    }

    public string Description
    {
        get;
        set;
    }

    public List<DbColumnInfoInput> DbColumnInfoList { get; set; }
}
