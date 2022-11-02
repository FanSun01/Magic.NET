using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysEmpSeedData : ISeedData , ISqlSugarEntitySeedData<SysEmp>
{  public IEnumerable<SysEmp> HasData()
    {  string json = @"[{""JobNum"":null,""OrgId"":177325089079365,""OrgName"":""系统机构"",""Id"":142307070910551},{""JobNum"":""1"",""OrgId"":175624015089733,""OrgName"":""土豆新车"",""Id"":175624015269957},{""JobNum"":null,""OrgId"":177325089079365,""OrgName"":""系统机构"",""Id"":177325484421189},{""JobNum"":null,""OrgId"":182313953165381,""OrgName"":""机构1"",""Id"":182314279026757},{""JobNum"":""1"",""OrgId"":278024843092037,""OrgName"":""租户1"",""Id"":278024843153477}]
";
 List<SysEmp> list = JsonUtil.ToObject<List<SysEmp>>(json);

        return list;
}}
