using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysRoleDataScopeSeedData : ISeedData , ISqlSugarEntitySeedData<SysRoleDataScope>
{  public IEnumerable<SysRoleDataScope> HasData()
    {  string json = @"[{""SysRoleId"":278024843124805,""SysOrgId"":278024843092037}]
";
 List<SysRoleDataScope> list = JsonUtil.ToObject<List<SysRoleDataScope>>(json);

        return list;
}}
