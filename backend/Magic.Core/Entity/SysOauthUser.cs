using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// Oauth登录用户表
/// </summary>
[SugarTable("sys_oauth_user")]
[Description("Oauth登录用户表")]
public class SysOauthUser : DEntityBase
{
    /// <summary>
    /// 第三方平台的用户唯一Id
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "第三方平台的用户唯一Id", IsNullable = true)]
    public string Uuid { get; set; }

    /// <summary>
    /// 用户授权的token
    /// </summary>
    [SugarColumn(ColumnDescription = "用户授权的token", IsNullable = true)]
    public string AccessToken { get; set; }

    /// <summary>
    /// 昵称
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "昵称", IsNullable = true)]
    public string NickName { get; set; }

    /// <summary>
    /// 头像
    /// </summary>
    [SugarColumn(ColumnDescription = "头像", IsNullable = true)]
    public string Avatar { get; set; }

    /// <summary>
    /// 性别
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "性别", IsNullable = true)]
    public string Gender { get; set; }

    /// <summary>
    /// 电话
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "电话", IsNullable = true)]
    public string Phone { get; set; }

    /// <summary>
    /// 邮箱
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "邮箱", IsNullable = true)]
    public string Email { get; set; }

    /// <summary>
    /// 位置
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "位置", IsNullable = true)]
    public string Location { get; set; }

    /// <summary>
    /// 用户网址
    /// </summary>
    [SugarColumn(ColumnDescription = "用户网址", IsNullable = true)]
    public string Blog { get; set; }

    /// <summary>
    /// 所在公司
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "所在公司", IsNullable = true)]
    public string Company { get; set; }

    /// <summary>
    /// 用户来源
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "用户来源", IsNullable = true)]
    public string Source { get; set; }

    /// <summary>
    /// 用户备注（各平台中的用户个人介绍）
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "用户备注（各平台中的用户个人介绍）", IsNullable = true)]
    public string Remark { get; set; }
}
