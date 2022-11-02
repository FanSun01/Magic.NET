using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysFileSeedData : ISeedData , ISqlSugarEntitySeedData<SysFile>
{  public IEnumerable<SysFile> HasData()
    {  string json = @"[{""FileLocation"":4,""FileBucket"":""LOCAL"",""FileOriginName"":""icon_avatar.png"",""FileSuffix"":""png"",""FileSizeKb"":""4"",""FileSizeInfo"":null,""FileObjectName"":""178111296725062.png"",""FilePath"":""Upload/Default"",""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":178111296725061},{""FileLocation"":4,""FileBucket"":""LOCAL"",""FileOriginName"":""icon_alipay.png"",""FileSuffix"":""png"",""FileSizeKb"":""22"",""FileSizeInfo"":null,""FileObjectName"":""188632919339077.png"",""FilePath"":""Upload/Avatar"",""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":188632919339077}]
";
 List<SysFile> list = JsonUtil.ToObject<List<SysFile>>(json);

        return list;
}}
