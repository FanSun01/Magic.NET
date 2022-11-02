using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysTimerSeedData : ISeedData , ISqlSugarEntitySeedData<SysTimer>
{  public IEnumerable<SysTimer> HasData()
    {  string json = @"[{""JobName"":""百度api"",""DoOnce"":false,""StartNow"":false,""ExecuteType"":1,""Interval"":5,""Cron"":null,""TimerType"":0,""RequestUrl"":""https://www.baidu.com"",""RequestParameters"":null,""Headers"":null,""RequestType"":2,""Remark"":""接口API"",""CreatedTime"":null,""UpdatedTime"":null,""CreatedUserId"":null,""CreatedUserName"":null,""UpdatedUserId"":null,""UpdatedUserName"":null,""IsDeleted"":false,""Id"":142307070910556},{""JobName"":""异常日志"",""DoOnce"":false,""StartNow"":false,""ExecuteType"":1,""Interval"":1,""Cron"":null,""TimerType"":0,""RequestUrl"":""LogJobWorker/DoLogEx"",""RequestParameters"":null,""Headers"":null,""RequestType"":0,""Remark"":"""",""CreatedTime"":null,""UpdatedTime"":""2021-07-22T17:49:29.37"",""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":142307070910551,""UpdatedUserName"":""superAdmin"",""IsDeleted"":false,""Id"":142307070910557},{""JobName"":""操作日志"",""DoOnce"":false,""StartNow"":false,""ExecuteType"":1,""Interval"":1,""Cron"":null,""TimerType"":0,""RequestUrl"":""LogJobWorker/DoLogOp"",""RequestParameters"":null,""Headers"":null,""RequestType"":0,""Remark"":"""",""CreatedTime"":null,""UpdatedTime"":""2021-07-22T17:49:31.363"",""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":142307070910551,""UpdatedUserName"":""superAdmin"",""IsDeleted"":false,""Id"":142307070910558},{""JobName"":""访问日志"",""DoOnce"":false,""StartNow"":false,""ExecuteType"":1,""Interval"":1,""Cron"":null,""TimerType"":0,""RequestUrl"":""LogJobWorker/DoLogVis"",""RequestParameters"":null,""Headers"":null,""RequestType"":0,""Remark"":"""",""CreatedTime"":null,""UpdatedTime"":""2021-07-22T17:49:33.267"",""CreatedUserId"":142307070910551,""CreatedUserName"":""superAdmin"",""UpdatedUserId"":142307070910551,""UpdatedUserName"":""superAdmin"",""IsDeleted"":false,""Id"":142307070910559}]
";
 List<SysTimer> list = JsonUtil.ToObject<List<SysTimer>>(json);

        return list;
}}
