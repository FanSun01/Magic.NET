namespace Magic.Core;

public class CommonConst
{
    #region 缓存
    /// <summary>
    /// 用户缓存
    /// </summary>
    public const string CACHE_KEY_USER = "user_";

    /// <summary>
    /// 菜单缓存
    /// </summary>
    public const string CACHE_KEY_MENU = "menu_";

    /// <summary>
    /// 权限缓存
    /// </summary>
    public const string CACHE_KEY_PERMISSION = "permission_";

    /// <summary>
    /// 数据范围缓存
    /// </summary>
    public const string CACHE_KEY_DATASCOPE = "datascope_";
    public const string CACHE_KEY_USERSDATASCOPE = "usersdatascope_";

    /// <summary>
    /// 验证码缓存
    /// </summary>
    public const string CACHE_KEY_CODE = "vercode_";

    /// <summary>
    /// 库表实体信息缓存
    /// </summary>
    public const string CACHE_KEY_ENTITYINFO = "tableentity";

    /// <summary>
    /// 所有权限缓存
    /// </summary>
    public const string CACHE_KEY_ALLPERMISSION = "allpermission";
    #endregion

    /// <summary>
    /// 程序集
    /// </summary>
    public static string[] ENTITY_ASSEMBLY_NAME = new string[] { "Magic.Core", "Magic.Application", "Magic.FlowCenter" };
    /// <summary>
    /// 删除字段
    /// </summary>
    public const string DELETE_FIELD = "IsDeleted";

    #region 数据库编号
    public const string MasterDb = "0";
	#endregion
}
