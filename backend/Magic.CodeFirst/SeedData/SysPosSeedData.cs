using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysPosSeedData : ISeedData , ISqlSugarEntitySeedData<SysPos>
{  public IEnumerable<SysPos> HasData()
    {  string json = @"[{""Name"":""系统职位"",""Code"":""SystemPos"",""Sort"":1,""Remark"":null,""Status"":0,""TenantId"":142307070918780,""CreatedTime"":""2021-07-05T11:58:54.63"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":177325394366533}]
";
 List<SysPos> list = JsonUtil.ToObject<List<SysPos>>(json);

        return list;
}}
