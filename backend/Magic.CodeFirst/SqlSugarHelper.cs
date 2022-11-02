using Magic.Core;
using Microsoft.Extensions.Configuration;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.CodeFirst;

public class SqlSugarHelper
{
    //用单例模式
  //  public static SqlSugarScope Db = new SqlSugarScope(new ConnectionConfig()
  //  {
  //      ConnectionString = "Server=.;Database=MagicCodeFirst;User=sa;Password=123456;MultipleActiveResultSets=True;",//连接符字串
  //      DbType = DbType.SqlServer,//数据库类型
  //      IsAutoCloseConnection = true //不设成true要手动close
  //  },
  //db => {
  //    //(A)全局生效配置点，一般AOP和程序启动的配置扔这里面 ，所有上下文生效
  //    //调试SQL事件，可以删掉
  //    db.Aop.OnLogExecuting = (sql, pars) =>
  //    {
  //        Console.WriteLine(sql);//输出sql,查看执行sql 性能无影响


  //        //5.0.8.2 获取无参数化 SQL  对性能有影响，特别大的SQL参数多的，调试使用
  //        //UtilMethods.GetSqlString(DbType.SqlServer,sql,pars)
  //    };

  //       //多个配置就写下面
  //       //db.Ado.IsDisableMasterSlaveSeparation=true;
  //   });


    public static ConnectionStringsOptions GetSetting()
    {
        var builder = new ConfigurationBuilder().SetBasePath(Directory.GetCurrentDirectory())
            .AddJsonFile("dbsettings.json", optional: false, reloadOnChange: true);


        IConfigurationRoot config = builder.Build();
        var conn = config.GetSection("ConnectionStrings").Get<ConnectionStringsOptions>();
        return conn;
    }


    public static SqlSugarScope Db()
    {
        //数据库序号从0开始,默认数据库为0
        var config = GetSetting();

        //默认数据库
        List<DbConfig> dbList = new List<DbConfig>();
        DbConfig defaultdb = new DbConfig()
        {
            DbNumber = config.DefaultDbNumber,
            DbString = config.DefaultDbString,
            DbType = config.DefaultDbType
        };
        dbList.Add(defaultdb);
        //业务数据库集合
        foreach (var item in config.DbConfigs)
        {
            dbList.Add(item);
        }

        List<ConnectionConfig> connectConfigList = new List<ConnectionConfig>();

        foreach (var item in dbList)
        {
            //防止数据库重复，导致的事务异常
            if (connectConfigList.Any(a => a.ConfigId == (dynamic)item.DbNumber || a.ConnectionString == item.DbString))
            {
                continue;
            }
            connectConfigList.Add(new ConnectionConfig()
            {
                ConnectionString = item.DbString,
                DbType = (DbType)Convert.ToInt32(Enum.Parse(typeof(DbType), item.DbType)),
                IsAutoCloseConnection = true,
                ConfigId = item.DbNumber,
                InitKeyType = InitKeyType.Attribute,
                MoreSettings = new ConnMoreSettings()
                {
                    IsAutoRemoveDataCache = true//自动清理缓存

                }
            });
        }

        return new SqlSugarScope(connectConfigList,
            //全局上下文生效
            db =>
            {
                /*
                 * 默认只会配置到第一个数据库，这里按照官方文档进行多数据库/多租户文档的说明进行循环配置
                 */
                foreach (var c in connectConfigList)
                {
                    var dbProvider = db.GetConnectionScope((string)c.ConfigId);
                    //执行超时时间
                    dbProvider.Ado.CommandTimeOut = 30;

                    dbProvider.Aop.OnLogExecuting = (sql, pars) =>
                    {
                        Console.WriteLine(sql);//输出sql,查看执行sql 性能无影响
                    };
                }
            });
    }
}
