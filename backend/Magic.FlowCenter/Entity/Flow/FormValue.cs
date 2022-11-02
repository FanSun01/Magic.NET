using System.Collections.Generic;

namespace Magic.FlowCenter.Entity;

	/// <summary>
	/// 表单设计类
	/// </summary>
	public class FormValue
{
    /// <summary>
    /// 表id
    /// </summary>
    public string id { get; set; }
    /// <summary>
    /// 说明
    /// </summary>
    public string label { get; set; }
    /// <summary>
    /// 序号
    /// </summary>
    public int index { get; set; }
    /// <summary>
    /// 标签
    /// </summary>
    public string tag { get; set; }
    /// <summary>
    /// 跨度
    /// </summary>
    public int span { get; set; }
    /// <summary>
    /// 表单
    /// </summary>
    public List<FormEx> columns { get; set; }
    /// <summary>
    /// 名称
    /// </summary>
    public string name { get; set; }
}
/// <summary>
/// 表单
/// </summary>
public class FormEx
{
    /// <summary>
    /// 跨度
    /// </summary>
    public int span { get; set; }
    /// <summary>
    /// 表单设计列表
    /// </summary>
    public List<FormValue> list { get; set; }
}
