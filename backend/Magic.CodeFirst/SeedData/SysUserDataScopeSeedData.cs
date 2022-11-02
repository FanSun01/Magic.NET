using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysUserDataScopeSeedData : ISeedData , ISqlSugarEntitySeedData<SysUserDataScope>
{  public IEnumerable<SysUserDataScope> HasData()
    {  string json = @"[{""SysUserId"":175624015269957,""SysOrgId"":175624015089733},{""SysUserId"":278024843153477,""SysOrgId"":278024843092037}]
";
 List<SysUserDataScope> list = JsonUtil.ToObject<List<SysUserDataScope>>(json);

        return list;
}}
