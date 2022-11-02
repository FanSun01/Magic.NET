using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class DocumentationSeedData : ISeedData , ISqlSugarEntitySeedData<Documentation>
{  public IEnumerable<Documentation> HasData()
    {  string json = @"[{""PId"":0,""PIds"":null,""Name"":""新建文件夹"",""DocumentType"":1,""FileSuffix"":null,""FileSizeKb"":null,""FilePath"":null,""FileObjectName"":null,""Label"":3,""Remark"":null,""Visible"":true,""Children"":null,""CreatedTime"":""2022-04-27T11:15:12.403"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":282067396128837},{""PId"":282067396128837,""PIds"":null,""Name"":""logo.png"",""DocumentType"":2,""FileSuffix"":"".png"",""FileSizeKb"":25,""FilePath"":""Upload/Document/2022/4/27"",""FileObjectName"":""282067842687045.png"",""Label"":null,""Remark"":null,""Visible"":true,""Children"":null,""CreatedTime"":""2022-04-27T11:17:01.427"",""UpdatedTime"":""2022-04-27T11:20:46.45"",""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":142307070910551,""UpdatedUserName"":""superAdmin"",""IsDeleted"":false,""Id"":282067842687046},{""PId"":282067396128837,""PIds"":null,""Name"":""呃呃呃"",""DocumentType"":1,""FileSuffix"":null,""FileSizeKb"":null,""FilePath"":null,""FileObjectName"":null,""Label"":3,""Remark"":null,""Visible"":true,""Children"":null,""CreatedTime"":""2022-04-27T11:21:14.207"",""UpdatedTime"":null,""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":282068878082117}]
";
 List<Documentation> list = JsonUtil.ToObject<List<Documentation>>(json);

        return list;
}}
