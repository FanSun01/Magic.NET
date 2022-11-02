using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysRoleSeedData : ISeedData , ISqlSugarEntitySeedData<SysRole>
{  public IEnumerable<SysRole> HasData()
    {  string json = @"[{""Name"":""系统管理员"",""Code"":""1"",""Sort"":0,""DataScopeType"":1,""Remark"":null,""Status"":0,""RoleType"":1,""TenantId"":175624014975045,""CreatedTime"":""2021-06-30T16:35:58.853"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":175624015192133},{""Name"":""财务"",""Code"":""cw"",""Sort"":100,""DataScopeType"":1,""Remark"":null,""Status"":0,""RoleType"":0,""TenantId"":175624014975045,""CreatedTime"":""2021-06-30T17:06:59.447"",""UpdatedTime"":null,""CreatedUserId"":175624015269957,""CreatedUserName"":""toudou@qq.com"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":175631636172869},{""Name"":""普通用户"",""Code"":""pt"",""Sort"":100,""DataScopeType"":1,""Remark"":null,""Status"":0,""RoleType"":0,""TenantId"":142307070918780,""CreatedTime"":""2021-06-30T17:13:32.56"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":175633246363717},{""Name"":""系统管理员"",""Code"":""1"",""Sort"":0,""DataScopeType"":1,""Remark"":null,""Status"":0,""RoleType"":1,""TenantId"":278024843046981,""CreatedTime"":""2022-04-16T01:06:00.987"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":278024843124805}]
";
 List<SysRole> list = JsonUtil.ToObject<List<SysRole>>(json);

        return list;
}}
