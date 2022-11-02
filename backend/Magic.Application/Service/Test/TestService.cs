using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Furion.JsonSerialization;
using Furion.Logging.Extensions;
using Magic.Core;
using Magic.Core.Entity;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Text.Json;
using System.Threading.Tasks;

namespace Magic.Application.Service;

[ApiDescriptionSettings("Application",Name = "Test", Order = 1)]
public class TestService : ITestService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<Documentation> _userRep;

    public TestService(SqlSugarRepository<Documentation> userRep)
    {
        _userRep=userRep;
    }

    [AllowAnonymous]
    public void TestDatabaseChange() {
        Type[] types = new Type[] { typeof(SysUser) };
        var diffString = _userRep.Context.CodeFirst.GetDifferenceTables(types).ToDiffList();
        Console.Write(diffString);
    }


    [HttpGet("/test/TestChangeDatabase")]
    [AllowAnonymous]
    public async Task TestChangeDatabase()
    {
        var user = await _userRep.ToListAsync();

        _userRep.CurrentBeginTran();
        _userRep.CurrentCommitTran();

    }

    [AllowAnonymous]
    public async Task<Student> JsonSerializerTest(string json) {
        string us = UserManager.Account;
        var sq = JsonSerializer.Deserialize<Student>(json);
        var ss= Newtonsoft.Json.JsonConvert.DeserializeObject<Student>(json);
        var s = JSON.Deserialize<Student>(json);
        return s;
    }

    [LoggingMonitor]
    public void TestLog()
    {
        throw Oops.Bah($"业务异常{DateTime.Now}");

    }
    [AllowAnonymous]
    public void TestLog2()
    {
        Student student = null;
        student.FirstName = "hahah";

    }

    [NonUnify]
    public void TestLogInfo()
    {
        $"info日志{DateTime.Now}".LogInformation();
    }

}

public class Student { 
    public string FirstName { get; set; }

    public int RealAge { get; set; }
}