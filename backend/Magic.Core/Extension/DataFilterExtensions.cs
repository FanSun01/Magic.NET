using Furion;
using Furion.FriendlyException;
using Microsoft.Extensions.DependencyInjection;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq.Dynamic.Core;
using System.Linq.Expressions;
using System.Reflection;
using System.Threading.Tasks;

namespace Magic.Core;

public static class DataFilterExtensions
	{
    /// <summary>
    /// 数据过滤,默认用户集合
    /// </summary>
    /// <param name="query">ISugarQueryable</param>
    /// <param name="parameter">目标表的parameter</param>
    /// <param name="type">默认用户集合</param>
    /// <param name="field">需要过滤的用户id字段,默认CreatedUserId和OrgId</param>
    /// <returns></returns>
    public static ISugarQueryable<TEntity> ToDataFilter<TEntity>(this ISugarQueryable<TEntity> query,string parameter="a", string field = "", FilterType type = FilterType.User)
    {
        Expression expression = null;
        var param = Expression.Parameter(typeof(TEntity), parameter);
        var dataScopes = GetDataScopeIdList(type).GetAwaiter().GetResult();
        switch (type)
        {
            case FilterType.User:
                if (string.IsNullOrEmpty(field))
                    field = "CreatedUserId";
                break;
            case FilterType.Org:
                if (string.IsNullOrEmpty(field))
                    field = "OrgId";
                break;
        }
        if (!UserManager.IsSuperAdmin)
        {
            PropertyInfo property = typeof(TEntity).GetProperty(field);
            if (property != null)
            {
                if (property.PropertyType == typeof(string))
					{
                    var temp = dataScopes.ToJsonString().ToObject<List<string>>();
                    expression = DynamicExpressionParser.ParseLambda(new[] { param }, typeof(bool), $"{field} in @0", temp);
                }
                else if (property.PropertyType == typeof(long?))
					{
                    var temp = dataScopes.ToJsonString().ToObject<List<long?>>();
                    expression = DynamicExpressionParser.ParseLambda(new[] { param }, typeof(bool), $"{field} in @0", temp);
                }
					else
					{
                    expression = DynamicExpressionParser.ParseLambda(new[] { param }, typeof(bool), $"{field} in @0", dataScopes);
                }
            }
        }
        if (expression != null && UserManager.UserId > 0)
        {
            query = query.Where((Expression<Func<TEntity, bool>>)expression);
        }
        return query;
    }
    /// <summary>
    /// 检查数据权限,默认用户集合
    /// </summary>
    /// <param name="field">检测的id</param>
    /// <param name="type">默认用户集合</param>
    public static async void CheckDataScope(this long field, FilterType type = FilterType.User)
    {
        // 如果当前用户不是超级管理员，则进行数据范围校验
        if (!UserManager.IsSuperAdmin)
        {
            var _scopeFactory = App.GetService<IServiceScopeFactory>();
            using (var scope = _scopeFactory.CreateScope())
            {
                var service = scope.ServiceProvider;
                var _sysUserService = App.GetService<Service.ISysUserService>(service);
                var dataScopes = new List<long>();
                switch (type)
                {
                    case FilterType.User:
                        dataScopes = await _sysUserService.GetDataScopeIdUserList(UserManager.UserId);
                        break;
                    case FilterType.Org:
                        dataScopes = await _sysUserService.GetUserDataScopeIdList(UserManager.UserId);
                        break;
                }
                if (dataScopes == null || field <= 0 || !dataScopes.Contains(field))
                    throw Oops.Oh(ErrorCode.D1013);
            }
        }
    }

    /// <summary>
    /// 获取当前数据权限,默认用户集合
    /// </summary>
    /// <param name="type">默认用户集合</param>
    /// <returns></returns>
    public static async  Task<List<long>> GetDataScopeIdList(FilterType type = FilterType.User)
		{
        var _scopeFactory = App.GetService<IServiceScopeFactory>();
        using (var scope = _scopeFactory.CreateScope())
        {
            var service = scope.ServiceProvider;
            var _sysUserService = App.GetService<Service.ISysUserService>(service);
            switch (type)
            {
                case FilterType.User:
                    return await _sysUserService.GetDataScopeIdUserList(UserManager.UserId);
                case FilterType.Org:
                    return await _sysUserService.GetUserDataScopeIdList(UserManager.UserId);
                default:
                    return await _sysUserService.GetUserDataScopeIdList(UserManager.UserId);
            }
        }
    }
}
