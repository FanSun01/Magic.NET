using Furion;
using Furion.Logging.Extensions;
using Magic.Core.Entity;
using Microsoft.Extensions.DependencyInjection;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;

namespace Magic.Core;

public static class SqlSugarSetup
{
    //public static void SqlSugarConfigure(this IServiceCollection services)
    //{
    //    #region 配置sqlsuagr
    //    List<ConnectionConfig> connectConfigList = new List<ConnectionConfig>();
    //    //数据库序号从0开始,默认数据库为0
    //    var config = App.GetOptions<ConnectionStringsOptions>();
    //    //默认数据库
    //    connectConfigList.Add(new ConnectionConfig
    //    {
    //        ConnectionString = config.DefaultDbString,
    //        DbType = (DbType)Convert.ToInt32(Enum.Parse(typeof(DbType), config.DefaultDbType)),
    //        IsAutoCloseConnection = true,
    //        ConfigId = config.DefaultDbNumber,
    //        InitKeyType = InitKeyType.Attribute,
    //        MoreSettings = new ConnMoreSettings()
    //        {
    //            IsAutoRemoveDataCache = true//自动清理缓存

    //        },
    //        ConfigureExternalServices = new ConfigureExternalServices()
    //        {
    //            EntityNameService = (type, entity) =>
    //            {
    //                var attributes = type.GetCustomAttributes(true);
    //                if (attributes.Any(it => it is TableAttribute))
    //                {
    //                    entity.DbTableName = (attributes.First(it => it is TableAttribute) as TableAttribute).Name;
    //                }
    //            },
    //            EntityService = (type, column) =>
    //            {
    //                var attributes = type.GetCustomAttributes(true);
    //		if (attributes.Any(it => it is KeyAttribute))// by attribute set primarykey
    //		{
    //			column.IsPrimarykey = true; //有哪些特性可以看 1.2 特性明细
    //		}
    //		if (attributes.Any(it => it is ColumnAttribute))
    //                {
    //                    column.DbColumnName = (attributes.First(it => it is ColumnAttribute) as ColumnAttribute).Name;
    //                }
    //            }
    //        }

    //    });
    //    if (config.DbConfigs == null)
    //        config.DbConfigs = new List<DbConfig>();
    //    //业务数据库集合
    //    foreach (var item in config.DbConfigs)
    //    {
    //        //防止数据库重复，导致的事务异常
    //        if (connectConfigList.Any(a => a.ConfigId == (dynamic)item.DbNumber || a.ConnectionString == item.DbString))
    //{
    //            continue;
    //}
    //        connectConfigList.Add(new ConnectionConfig
    //        {
    //            ConnectionString = item.DbString,
    //            DbType = (DbType)Convert.ToInt32(Enum.Parse(typeof(DbType), item.DbType)),
    //            IsAutoCloseConnection = true,
    //            ConfigId = item.DbNumber,
    //            InitKeyType = InitKeyType.Attribute,
    //            MoreSettings = new ConnMoreSettings()
    //            {
    //                IsAutoRemoveDataCache = true//自动清理缓存
    //            }
    //        });
    //    }
    //    List<Type> types = App.EffectiveTypes.Where(a => !a.IsAbstract && a.IsClass && a.GetCustomAttributes(typeof(SugarTable), true)?.FirstOrDefault() != null).ToList();
    //    //sugar action
    //    Action<ISqlSugarClient> configure = db =>
    //    {
    //        connectConfigList.ForEach(config => {
    //            string temp = config.ConfigId;
    //            var _db = db.AsTenant().GetConnection(temp);
    //            _db.CurrentConnectionConfig.ConfigureExternalServices = new ConfigureExternalServices()
    //             {
    //                 DataInfoCacheService = new SqlSugarCache()//配置我们创建的缓存类
    //             };
    //            //执行超时时间
    //            _db.Ado.CommandTimeOut = 30;
    //            _db.Aop.OnLogExecuting = (sql, pars) =>
    //            {
    //                if (sql.StartsWith("SELECT"))
    //                {
    //                    Console.ForegroundColor = ConsoleColor.Green;
    //                }
    //                if (sql.StartsWith("UPDATE") || sql.StartsWith("INSERT"))
    //                {
    //                    Console.ForegroundColor = ConsoleColor.White;
    //                }
    //                if (sql.StartsWith("DELETE"))
    //                {
    //                    Console.ForegroundColor = ConsoleColor.Blue;
    //                }
    //                //App.PrintToMiniProfiler("SqlSugar", "Info", sql + "\r\n" + _db.Utilities.SerializeObject(pars.ToDictionary(it => it.ParameterName, it => it.Value)));
    //                Console.WriteLine("Sql:" + "\r\n\r\n" + UtilMethods.GetSqlString(db.CurrentConnectionConfig.DbType, sql, pars));
    //                App.PrintToMiniProfiler("SqlSugar", "Info", UtilMethods.GetSqlString(db.CurrentConnectionConfig.DbType, sql, pars));
    //            };


    //            _db.Aop.DataExecuting = (oldValue, entityInfo) =>
    //            {
    //                // 新增操作
    //                if (entityInfo.OperationType == DataFilterType.InsertByObject)
    //                {
    //                    // 主键(long)-赋值雪花Id
    //                    if (entityInfo.EntityColumnInfo.IsPrimarykey && entityInfo.EntityColumnInfo.PropertyInfo.PropertyType == typeof(long)) {
    //                        var id = ((dynamic)entityInfo.EntityValue).Id;
    //                        if (id == null || id == 0)
    //                            entityInfo.SetValue(Yitter.IdGenerator.YitIdHelper.NextId());
    //                    }


    //                    if (entityInfo.PropertyName == "CreatedTime")
    //                        entityInfo.SetValue(DateTime.Now);
    //                    if (App.User != null)
    //                    {
    //                        if (entityInfo.PropertyName == "TenantId")
    //                        {
    //                            var tenantId = ((dynamic)entityInfo.EntityValue).TenantId;
    //                            if (tenantId == null || tenantId == 0)
    //                                entityInfo.SetValue(App.User.FindFirst(ClaimConst.TENANT_ID)?.Value);
    //                        }
    //                        if (entityInfo.PropertyName == "CreatedUserId") {
    //                            var createUserId = ((dynamic)entityInfo.EntityValue).CreatedUserId;
    //                            if (createUserId == null || createUserId == 0)
    //                                entityInfo.SetValue(App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value);
    //                        }

    //                        if (entityInfo.PropertyName == "CreatedUserName")
    //                            entityInfo.SetValue(App.User.FindFirst(ClaimConst.CLAINM_NAME)?.Value);
    //                        //if (entityInfo.PropertyName == "CreateOrgId")
    //                        //    entityInfo.SetValue(App.User.FindFirst(ClaimConst.OrgId)?.Value);
    //                    }
    //                }
    //                // 更新操作
    //                if (entityInfo.OperationType == DataFilterType.UpdateByObject)
    //                {
    //                    if (entityInfo.PropertyName == "UpdatedTime")
    //                        entityInfo.SetValue(DateTime.Now);
    //                    if (entityInfo.PropertyName == "UpdatedUserId")
    //                        entityInfo.SetValue(App.User?.FindFirst(ClaimConst.CLAINM_USERID)?.Value);
    //                    if (entityInfo.PropertyName == "UpdatedUserName")
    //                        entityInfo.SetValue(App.User?.FindFirst(ClaimConst.CLAINM_NAME)?.Value);

    //                }
    //            };

    //            //全局过滤器
    //            var superAdminViewAllData = Convert.ToBoolean(App.GetOptions<SystemSettingsOptions>().SuperAdminViewAllData);
    //            foreach (var entityType in types)
    //            {
    //                // 配置多租户全局过滤器
    //                if (!entityType.GetProperty(ClaimConst.TENANT_ID).IsEmpty())
    //                { //判断实体类中包含TenantId属性
    //                  //构建动态Lambda
    //                    var lambda = DynamicExpressionParser.ParseLambda
    //                    (new[] { Expression.Parameter(entityType, "it") },
    //                     typeof(bool), $"{nameof(DBEntityTenant.TenantId)} ==  @0 or (@1 and @2)",
    //                      GetTenantId(), IsSuperAdmin(), superAdminViewAllData);
    //                    _db.QueryFilter.Add(new TableFilterItem<object>(entityType, lambda)); //将Lambda传入过滤器
    //                }
    //                // 配置加删除全局过滤器
    //                if (!entityType.GetProperty(CommonConst.DELETE_FIELD).IsEmpty())
    //                { //判断实体类中包含IsDeleted属性
    //                  //构建动态Lambda
    //                    var lambda = DynamicExpressionParser.ParseLambda
    //                    (new[] { Expression.Parameter(entityType, "it") },
    //                     typeof(bool), $"{nameof(DEntityBase.IsDeleted)} ==  @0",
    //                      false);
    //                    _db.QueryFilter.Add(new TableFilterItem<object>(entityType, lambda)
    //                    {
    //                        IsJoinQuery = true
    //                    }); //将Lambda传入过滤器
    //                }
    //            }
    //        });
    //    };
    //    services.AddSqlSugar(connectConfigList, configure);
    //    #endregion
    //}


    /// <summary>
    /// SqlsugarScope的配置
    /// Scope必须用单例注入
    /// 不可以用Action委托注入
    /// </summary>
    /// <param name="services"></param>
    public static void SqlSugarScopeConfigure(this IServiceCollection services)
    {
        //数据库序号从0开始,默认数据库为0
        var config = App.GetConfig<ConnectionStringsOptions>("ConnectionStrings",true);

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

                },
                ConfigureExternalServices = new ConfigureExternalServices()
                {
                    DataInfoCacheService = new SqlSugarCache(),
                    EntityNameService = (type, entity) =>
                    {
                        var attributes = type.GetCustomAttributes(true);
                        if (attributes.Any(it => it is TableAttribute))
                        {
                            entity.DbTableName = (attributes.First(it => it is TableAttribute) as TableAttribute).Name;
                        }
                    },
                    EntityService = (type, column) =>
                    {
                        var attributes = type.GetCustomAttributes(true);
                        if (attributes.Any(it => it is KeyAttribute))// by attribute set primarykey
                        {
                            column.IsPrimarykey = true; //有哪些特性可以看 1.2 特性明细
                        }
                        if (attributes.Any(it => it is ColumnAttribute))
                        {
                            column.DbColumnName = (attributes.First(it => it is ColumnAttribute) as ColumnAttribute).Name;
                        }
                    }
                }
            });
        }

        List<Type> types = App.EffectiveTypes.Where(a => !a.IsAbstract && a.IsClass && a.GetCustomAttributes(typeof(SugarTable), true)?.FirstOrDefault() != null).ToList();

        SqlSugarScope sqlSugarScope = new SqlSugarScope(connectConfigList,
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
                        if (sql.StartsWith("SELECT"))
                        {
                            Console.ForegroundColor = ConsoleColor.Green;
                        }
                        if (sql.StartsWith("UPDATE") || sql.StartsWith("INSERT"))
                        {
                            Console.ForegroundColor = ConsoleColor.White;
                        }
                        if (sql.StartsWith("DELETE"))
                        {
                            Console.ForegroundColor = ConsoleColor.Blue;
                        }
                        //Console.WriteLine("Sql:" + "\r\n\r\n" + UtilMethods.GetSqlString(c.DbType, sql, pars));
                        App.PrintToMiniProfiler("SqlSugar", "Info", UtilMethods.GetSqlString(c.DbType, sql, pars));
                        $"DB:{c.ConfigId}, Sql:\r\n\r\n { UtilMethods.GetSqlString(c.DbType, sql, pars)}".LogInformation();


                    };

                    dbProvider.Aop.DataExecuting = (oldValue, entityInfo) =>
                    {
                        // 新增操作
                        if (entityInfo.OperationType == DataFilterType.InsertByObject)
                        {
                            // 主键(long)-赋值雪花Id
                            if (entityInfo.EntityColumnInfo.IsPrimarykey && entityInfo.EntityColumnInfo.PropertyInfo.PropertyType == typeof(long))
                            {
                                var id = ((dynamic)entityInfo.EntityValue).Id;
                                if (id == null || id == 0)
                                    entityInfo.SetValue(Yitter.IdGenerator.YitIdHelper.NextId());
                            }


                            if (entityInfo.PropertyName == "CreatedTime")
                                entityInfo.SetValue(DateTime.Now);
                            if (App.User != null)
                            {
                                if (entityInfo.PropertyName == "TenantId")
                                {
                                    var tenantId = ((dynamic)entityInfo.EntityValue).TenantId;
                                    if (tenantId == null || tenantId == 0)
                                        entityInfo.SetValue(App.User.FindFirst(ClaimConst.TENANT_ID)?.Value);
                                }
                                if (entityInfo.PropertyName == "CreatedUserId")
                                {
                                    var createUserId = ((dynamic)entityInfo.EntityValue).CreatedUserId;
                                    if (createUserId == null || createUserId == 0)
                                        entityInfo.SetValue(App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value);
                                }

                                if (entityInfo.PropertyName == "CreatedUserName")
                                    entityInfo.SetValue(App.User.FindFirst(ClaimConst.CLAINM_NAME)?.Value);
                            }
                        }
                        // 更新操作
                        if (entityInfo.OperationType == DataFilterType.UpdateByObject)
                        {
                            if (entityInfo.PropertyName == "UpdatedTime")
                                entityInfo.SetValue(DateTime.Now);
                            if (entityInfo.PropertyName == "UpdatedUserId")
                                entityInfo.SetValue(App.User?.FindFirst(ClaimConst.CLAINM_USERID)?.Value);
                            if (entityInfo.PropertyName == "UpdatedUserName")
                                entityInfo.SetValue(App.User?.FindFirst(ClaimConst.CLAINM_NAME)?.Value);

                        }
                    };

                    /* 
                     * 使用 SqlSugarScope 循环配置此项的时候会覆盖整个 ConfigureExternalServices，
                     * 移动到 New ConnectionConfig中配置
                     */
                    //db.CurrentConnectionConfig.ConfigureExternalServices = new ConfigureExternalServices()
                    //{
                    //    DataInfoCacheService = new SqlSugarCache()//配置我们创建的缓存类
                    //};

                    //全局过滤器
                    var superAdminViewAllData = Convert.ToBoolean(App.GetOptions<SystemSettingsOptions>().SuperAdminViewAllData);
                    foreach (var entityType in types)
                    {
                        // 配置多租户全局过滤器
                        if (!entityType.GetProperty(ClaimConst.TENANT_ID).IsEmpty())
                        { //判断实体类中包含TenantId属性
                          //构建动态Lambda
                            var lambda = DynamicExpressionParser.ParseLambda
                            (new[] { Expression.Parameter(entityType, "it") },
                             typeof(bool), $"{nameof(DBEntityTenant.TenantId)} ==  @0 or (@1 and @2)",
                              GetTenantId(), IsSuperAdmin(), superAdminViewAllData);
                            dbProvider.QueryFilter.Add(new TableFilterItem<object>(entityType, lambda)); //将Lambda传入过滤器
                        }
                        // 配置加删除全局过滤器
                        if (!entityType.GetProperty(CommonConst.DELETE_FIELD).IsEmpty())
                        { //判断实体类中包含IsDeleted属性
                          //构建动态Lambda
                            var lambda = DynamicExpressionParser.ParseLambda
                            (new[] { Expression.Parameter(entityType, "it") },
                             typeof(bool), $"{nameof(DEntityBase.IsDeleted)} ==  @0",
                              false);
                            dbProvider.QueryFilter.Add(new TableFilterItem<object>(entityType, lambda)
                            {
                                IsJoinQuery = true
                            }); //将Lambda传入过滤器
                        }
                    }

                }
            });
        services.AddSingleton<ISqlSugarClient>(sqlSugarScope);
        // 注册 SqlSugar 仓储
        services.AddScoped(typeof(SqlSugarRepository<>));
    }



    /// <summary>
    /// 获取当前租户id
    /// </summary>
    /// <returns></returns>
    private static object GetTenantId()
    {
        if (App.User == null) return null;
        return App.User.FindFirst(ClaimConst.TENANT_ID)?.Value;
    }

    /// <summary>
    /// 判断是不是超级管理员
    /// </summary>
    /// <returns></returns>
    private static bool IsSuperAdmin()
    {
        if (App.User == null) return false;
        return App.User.FindFirst(ClaimConst.CLAINM_SUPERADMIN)?.Value == AdminType.SuperAdmin.GetHashCode().ToString();
    }
    /// <summary>
    /// 添加 SqlSugar 拓展
    /// </summary>
    /// <param name="services"></param>
    /// <param name="config"></param>
    /// <param name="buildAction"></param>
    /// <returns></returns>
    public static IServiceCollection AddSqlSugar(this IServiceCollection services, ConnectionConfig config, Action<ISqlSugarClient> buildAction = default)
    {
        var list = new List<ConnectionConfig>();
        list.Add(config);
        return services.AddSqlSugar(list, buildAction);
    }

    /// <summary>
    /// 添加 SqlSugar 拓展
    /// </summary>
    /// <param name="services"></param>
    /// <param name="configs"></param>
    /// <param name="buildAction"></param>
    /// <returns></returns>
    public static IServiceCollection AddSqlSugar(this IServiceCollection services, List<ConnectionConfig> configs, Action<ISqlSugarClient> buildAction = default)
    {
        // 注册 SqlSugar 客户端
        services.AddScoped<ISqlSugarClient>(u =>
        {
            var db = new SqlSugarClient(configs);
            buildAction?.Invoke(db);
            return db;
        });

        // 注册 SqlSugar 仓储
        services.AddScoped(typeof(SqlSugarRepository<>));
        return services;
    }
}
