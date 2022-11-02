using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysUserRoleSeedData : ISeedData , ISqlSugarEntitySeedData<SysUserRole>
{  public IEnumerable<SysUserRole> HasData()
    {  string json = @"[{""SysUserId"":175624015269957,""SysRoleId"":175624015192133},{""SysUserId"":177325484421189,""SysRoleId"":175633246363717},{""SysUserId"":182314279026757,""SysRoleId"":175633246363717},{""SysUserId"":278024843153477,""SysRoleId"":278024843124805}]
";
 List<SysUserRole> list = JsonUtil.ToObject<List<SysUserRole>>(json);

        return list;
}}
