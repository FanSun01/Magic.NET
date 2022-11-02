using SqlSugar;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Entity;

/// <summary>
/// 代码生成字段配置表
/// </summary>
[SugarTable("sys_code_gen_config")]
[Description("代码生成字段配置表")]
public class SysCodeGenConfig : DEntityBase
{
    /// <summary>
    /// 代码生成主表ID
    /// </summary>
    [SugarColumn(ColumnDescription = "代码生成主表ID")]
    public long CodeGenId { get; set; }

    /// <summary>
    /// 数据库字段名
    /// </summary>
    [Required, MaxLength(100)]
    [SugarColumn(ColumnDescription = "数据库字段名")]
    public string ColumnName { get; set; }

    /// <summary>
    /// 字段描述
    /// </summary>
    [MaxLength(100)]
    [SugarColumn(ColumnDescription = "字段描述",IsNullable =true)]
    public string ColumnComment { get; set; }

    /// <summary>
    /// .NET数据类型
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = ".NET数据类型", IsNullable = true)]
    public string NetType { get; set; }

    /// <summary>
    /// 作用类型（字典）
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "作用类型（字典）", IsNullable = true)]
    public string EffectType { get; set; }

    /// <summary>
    /// 外键实体名称
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "外键实体名称", IsNullable = true)]
    public string FkEntityName { get; set; }

    /// <summary>
    /// 外键显示字段
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "外键显示字段", IsNullable = true)]
    public string FkColumnName { get; set; }

    /// <summary>
    /// 外键显示字段.NET类型
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "外键显示字段.NET类型", IsNullable = true)]
    public string FkColumnNetType { get; set; }

    /// <summary>
    /// 字典code
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "字典code", IsNullable = true)]
    public string DictTypeCode { get; set; }

    /// <summary>
    /// 列表是否缩进（字典）
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "列表是否缩进（字典）", IsNullable = true)]
    public string WhetherRetract { get; set; }

    /// <summary>
    /// 是否必填（字典）
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否必填（字典）", IsNullable = true)]
    public string WhetherRequired { get; set; }

    /// <summary>
    /// 是否是查询条件
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否是查询条件", IsNullable = true)]
    public string QueryWhether { get; set; }

    /// <summary>
    /// 查询方式
    /// </summary>
    [MaxLength(10)]
    [SugarColumn(ColumnDescription = "查询方式", IsNullable = true)]
    public string QueryType { get; set; }

    /// <summary>
    /// 列表显示
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "列表显示", IsNullable = true)]
    public string WhetherTable { get; set; }

    /// <summary>
    /// 增改
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "增改", IsNullable = true)]
    public string WhetherAddUpdate { get; set; }

    /// <summary>
    /// 主键
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "主键", IsNullable = true)]
    public string ColumnKey { get; set; }

    /// <summary>
    /// 数据库中类型（物理类型）
    /// </summary>
    [MaxLength(50)]
    [SugarColumn(ColumnDescription = "数据库中类型（物理类型）", IsNullable = true)]
    public string DataType { get; set; }

    /// <summary>
    /// 是否通用字段
    /// </summary>
    [MaxLength(5)]
    [SugarColumn(ColumnDescription = "是否通用字段", IsNullable = true)]
    public string WhetherCommon { get; set; }
}
