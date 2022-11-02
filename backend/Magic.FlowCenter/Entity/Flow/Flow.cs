using System.Collections.Generic;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 流程
/// </summary>
	public class Flow
{
    /// <summary>
    /// 流程配置
    /// </summary>
    public FlowConfig config { get; set; }
    /// <summary>
    /// 参数
    /// </summary>
    public Attr attr { get; set; }
    /// <summary>
    /// 状态
    /// </summary>
    public string status { get; set; }
    /// <summary>
    /// 连线
    /// </summary>
    public List<FlowLine> linkList { get; set; }
    /// <summary>
    /// 节点
    /// </summary>
    public List<FlowNode> nodeList { get; set; }
    /// <summary>
    /// 泳道
    /// </summary>
    public List<FlowArea> areaList { get; set; }
}
/// <summary>
/// 流程配置
/// </summary>
public class FlowConfig {
    /// <summary>
    /// 网格
    /// </summary>
    public bool showGrid { get; set; }
    /// <summary>
    /// 文字
    /// </summary>
    public string showGridText { get; set; }
    /// <summary>
    /// 图标
    /// </summary>
    public string showGridIcon { get; set; }
}
/// <summary>
/// 参数
/// </summary>
public class Attr
{
    public string id { get; set; }
}
