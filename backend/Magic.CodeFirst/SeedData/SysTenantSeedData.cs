using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysTenantSeedData : ISeedData , ISqlSugarEntitySeedData<SysTenant>
{  public IEnumerable<SysTenant> HasData()
    {  string json = @"[{""Name"":""系统租户"",""AdminName"":""SystemAdmin"",""Host"":null,""Email"":""SystemAdmin"",""Phone"":null,""Connection"":null,""Schema"":null,""Remark"":null,""TenantType"":1,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070918780},{""Name"":""土豆新车"",""AdminName"":""tdadmin"",""Host"":null,""Email"":""toudou@qq.com"",""Phone"":null,""Connection"":null,""Schema"":null,""Remark"":null,""TenantType"":0,""CreatedTime"":""2021-06-30T16:35:58.803"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":175624014975045},{""Name"":""租户1"",""AdminName"":""租户1管理员"",""Host"":null,""Email"":""zuhutest"",""Phone"":null,""Connection"":null,""Schema"":null,""Remark"":null,""TenantType"":0,""CreatedTime"":""2022-04-16T01:06:00.967"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":278024843046981}]
";
 List<SysTenant> list = JsonUtil.ToObject<List<SysTenant>>(json);

        return list;
}}
