using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysCodeGenSeedData : ISeedData , ISqlSugarEntitySeedData<SysCodeGen>
{  public IEnumerable<SysCodeGen> HasData()
    {  string json = @"[{""AuthorName"":""Magic"",""TablePrefix"":null,""GenerateType"":""2"",""TableName"":""Test"",""NameSpace"":""Magic.Application"",""BusName"":""测试"",""MenuApplication"":""busiapp"",""MenuPid"":0,""CreatedTime"":""2022-05-25T09:15:02.367"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""超级管理员"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":291946907033669}]
";
 List<SysCodeGen> list = JsonUtil.ToObject<List<SysCodeGen>>(json);

        return list;
}}
