using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysOrgSeedData : ISeedData , ISqlSugarEntitySeedData<SysOrg>
{  public IEnumerable<SysOrg> HasData()
    {  string json = @"[{""Pid"":0,""Pids"":""[0],"",""Name"":""土豆新车"",""Code"":""1"",""Contacts"":""tdadmin"",""Tel"":null,""Sort"":0,""Remark"":null,""Status"":0,""TenantId"":175624014975045,""CreatedTime"":""2021-06-30T16:35:58.83"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":175624015089733},{""Pid"":0,""Pids"":""[0],"",""Name"":""系统机构"",""Code"":""SystemOrg"",""Contacts"":null,""Tel"":null,""Sort"":1,""Remark"":null,""Status"":0,""TenantId"":142307070918780,""CreatedTime"":""2021-07-05T11:57:40.097"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":177325089079365},{""Pid"":177325089079365,""Pids"":""[0],[177325089079365],"",""Name"":""机构1"",""Code"":""1"",""Contacts"":null,""Tel"":null,""Sort"":100,""Remark"":null,""Status"":0,""TenantId"":142307070918780,""CreatedTime"":""2021-07-19T14:17:24.493"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":182313953165381},{""Pid"":182313953165381,""Pids"":""[0],[177325089079365],[182313953165381],"",""Name"":""机构2"",""Code"":""2"",""Contacts"":null,""Tel"":null,""Sort"":100,""Remark"":null,""Status"":0,""TenantId"":142307070918780,""CreatedTime"":""2021-07-19T14:17:38.037"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":182314008641605},{""Pid"":0,""Pids"":""[0],"",""Name"":""租户1"",""Code"":""1"",""Contacts"":""租户1管理员"",""Tel"":null,""Sort"":0,""Remark"":null,""Status"":0,""TenantId"":278024843046981,""CreatedTime"":""2022-04-16T01:06:00.98"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":278024843092037}]
";
 List<SysOrg> list = JsonUtil.ToObject<List<SysOrg>>(json);

        return list;
}}
