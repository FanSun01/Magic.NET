using System.Collections;
using System.Collections.Generic;

namespace Magic.Core.Service;

/// <summary>
/// 菜单树---授权、新增编辑时选择
/// </summary>
public class MenuTreeOutput : ITreeNode
{
    /// <summary>
    /// 主键
    /// </summary>
    public long Id { get; set; }

    /// <summary>
    /// 父Id
    /// </summary>
    public long ParentId { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public string Title { get; set; }

    /// <summary>
    /// 值
    /// </summary>
    public string Value { get; set; }

    /// <summary>
    /// 排序，越小优先级越高
    /// </summary>
    public int Weight { get; set; }

    /// <summary>
    /// 子节点
    /// </summary>
    public List<MenuTreeOutput> Children { get; set; } = new List<MenuTreeOutput>();

    /// <summary>
    /// 应用名称
    /// </summary>
    [System.Text.Json.Serialization.JsonIgnore]
    public string AppName { get; set; }

    /// <summary>
    /// 应用编码
    /// </summary>
    public string AppCode { get; set; }

    /// <summary>
    /// 引用排序
    /// </summary>
    [System.Text.Json.Serialization.JsonIgnore]
    public int AppSort { get; set; }

    public long GetId()
    {
        return Id;
    }

    public long GetPid()
    {
        return ParentId;
    }

    public void SetChildren(IList children)
    {
        Children = (List<MenuTreeOutput>)children;
    }
}
