using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysAppSeedData : ISeedData , ISqlSugarEntitySeedData<SysApp>
{  public IEnumerable<SysApp> HasData()
    {  string json = @"[{""Name"":""平台管理"",""Code"":""system"",""Active"":""Y"",""Status"":0,""Sort"":100,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070898245},{""Name"":""系统管理"",""Code"":""manage"",""Active"":""N"",""Status"":0,""Sort"":300,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070902341},{""Name"":""运营管理"",""Code"":""platform"",""Active"":""N"",""Status"":0,""Sort"":200,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070922826},{""Name"":""业务应用"",""Code"":""busiapp"",""Active"":""N"",""Status"":0,""Sort"":400,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070922869},{""Name"":""流程中心"",""Code"":""flowcenter"",""Active"":""N"",""Status"":0,""Sort"":500,""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":246681684324421}]
";
 List<SysApp> list = JsonUtil.ToObject<List<SysApp>>(json);

        return list;
}}
