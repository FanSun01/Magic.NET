using SqlSugar;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
namespace Magic.Core.Entity;

/// <summary>
/// 菜单表
/// </summary>
[SugarTable("sys_menu")]
[Description("菜单表")]
public class SysMenu : DEntityBase
{
    /// <summary>
    /// 父Id
    /// </summary>
    [SugarColumn(ColumnDescription = "父Id")]
    public long Pid { get; set; }

    /// <summary>
    /// 父Ids
    /// </summary>
    [SugarColumn(ColumnDescription = "父Ids")]
    public string Pids { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    [Required, MaxLength(20)]
    [SugarColumn(ColumnDescription = "名称")]
    public string Name { get; set; }

    /// <summary>
    /// 编码
    /// </summary>
    [Required, MaxLength(50)]
    [SugarColumn(ColumnDescription = "编码")]
    public string Code { get; set; }

    /// <summary>
    /// 菜单类型（字典 0目录 1菜单 2按钮）
    /// </summary>
    [SugarColumn(ColumnDescription = "菜单类型（字典 0目录 1菜单 2按钮）")]
    public int Type { get; set; }

    /// <summary>
    /// 图标
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "图标", IsNullable = true)]
    public string Icon { get; set; }

    /// <summary>
    /// 路由地址
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "路由地址", IsNullable = true)]
    public string Router { get; set; }

    /// <summary>
    /// 组件地址
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "组件地址", IsNullable = true)]
    public string Component { get; set; }

    /// <summary>
    /// 权限标识
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "权限标识", IsNullable = true)]
    public string Permission { get; set; }

    /// <summary>
    /// 应用分类（应用编码）
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "应用分类（应用编码）", IsNullable = true)]
    public string Application { get; set; }

    /// <summary>
    /// 打开方式（字典 0无 1组件 2内链 3外链）
    /// </summary>
    [SugarColumn(ColumnDescription = "打开方式（字典 0无 1组件 2内链 3外链）")]
    public int OpenType { get; set; } = 0;

    /// <summary>
    /// 是否可见（Y-是，N-否）
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否可见（Y-是，N-否）", IsNullable = true)]
    public string Visible { get; set; } = "Y";

    /// <summary>
    /// 内链地址
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "内链地址", IsNullable = true)]
    public string Link { get; set; }

    /// <summary>
    /// 重定向地址
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "重定向地址", IsNullable = true)]
    public string Redirect { get; set; }

    /// <summary>
    /// 权重（字典 1系统权重 2业务权重）
    /// </summary>
    [SugarColumn(ColumnDescription = "权重（字典 1系统权重 2业务权重）")]
    public int Weight { get; set; } = 2;

    /// <summary>
    /// 排序
    /// </summary>
    [SugarColumn(ColumnDescription = "排序")]
    public int Sort { get; set; } = 100;

    /// <summary>
    /// 备注
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "备注", IsNullable = true)]
    public string Remark { get; set; }

    /// <summary>
    /// 状态（字典 0正常 1停用 2删除）
    /// </summary>
    [SugarColumn(ColumnDescription = "状态（字典 0正常 1停用 2删除）")]
    public CommonStatus Status { get; set; } = CommonStatus.ENABLE;

}
