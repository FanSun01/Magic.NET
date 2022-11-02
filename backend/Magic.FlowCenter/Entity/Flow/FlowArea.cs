namespace Magic.FlowCenter.Entity;

/// <summary>
/// 流程泳道
/// </summary>
	public class FlowArea
{
    public const string YLANE = "y-lane";   //y泳道
    public const string XLANE = "x-lane";   //x泳道
    /// <summary>
    /// 泳道Id
    /// </summary>
    public string id { get; set; }
    /// <summary>
    /// 名称
    /// </summary>
    public string name { get; set; }
    /// <summary>
    /// 类型
    /// </summary>
    public string type { get; set; }
    /// <summary>
    /// 图标
    /// </summary>
    public string icon { get; set; }
    /// <summary>
    /// x坐标
    /// </summary>
    public int x { get; set; }
    /// <summary>
    /// y坐标
    /// </summary>
    public int y { get; set; }
    /// <summary>
    /// 宽度
    /// </summary>
    public int width { get; set; }
    /// <summary>
    /// 高度
    /// </summary>
    public int height { get; set; }
}
