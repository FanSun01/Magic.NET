using System.Collections.Generic;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 流程节点
/// </summary>
public class FlowNode
{
    public const string START = "start round mix";
    public const string END = "end round";
    public const string NODE = "node";
    public const string FORK = "fork";   //会签开始节点
    public const string JOIN = "join";   //会签结束节点
    /// <summary>
    /// id
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
    /// y左边
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

    /// <summary>
    /// 节点的附加数据项
    /// </summary>
    /// <value>The set information.</value>
    public Setinfo setInfo { get; set; }
}
/// <summary>
/// 节点详细
/// </summary>
public class Setinfo
{
    public const string SPECIAL_USER = "SPECIAL_USER";  //指定用户
    public const string ALL_USER = "ALL_USER";  //所有用户
    public const string SPECIAL_ROLE = "SPECIAL_ROLE";  //指定角色
    public const string RUNTIME_SPECIAL_ROLE = "RUNTIME_SPECIAL_ROLE"; //运行时指定角色
    public const string RUNTIME_SPECIAL_USER = "RUNTIME_SPECIAL_USER"; //运行时指定用户

    /// <summary>
    /// 节点执行权限类型
    /// </summary>
    public string NodeDesignate { get; set; }
    /// <summary>
    /// 选择值
    /// </summary>
    public List<string> NodeDesignateData { get; set; }
    /// <summary>
    /// 选择显示
    /// </summary>
    public List<string> NodeDesignateName { get; set; }
    /// <summary>
    /// 当前部门
    /// </summary>
    public bool CurrentDepart { get; set; } = false;
    /// <summary>
    /// 节点编号
    /// </summary>
    public string NodeCode { get; set; }
    /// <summary>
    /// 节点名称
    /// </summary>
    public string NodeName { get; set; }
    /// <summary>
    ///  流程执行时，三方回调的URL地址
    /// </summary>
    public string ThirdPartyUrl { get; set; }

    /// <summary>
    /// 驳回节点0"前一步"1"第一步"2"某一步" 3"不处理"
    /// </summary>
    public string NodeRejectType { get; set; } = "1";
    /// <summary>
    /// 节点状态
    /// </summary>
    public int? Taged { get; set; }
    /// <summary>
    /// 用户名称
    /// </summary>
    public string UserName { get; set; }
    /// <summary>
    /// 用户Id
    /// </summary>
    public long? UserId { get; set; }
    /// <summary>
    /// 描述
    /// </summary>
    public string Description { get; set; }
    /// <summary>
    /// 节点时间
    /// </summary>
    public string TagedTime { get; set; }

    /// <summary>
    ///  节点会签方式，all/空：默认为全部通过，one ：至少有一个通过
    /// </summary>
    public string NodeConfluenceType { get; set; } = "all";

    /// <summary>
    /// 会签通过的个数
    /// </summary>
    public int? ConfluenceOk { get; set; }

    /// <summary>
    /// 会签拒绝的个数
    /// </summary>
    public int? ConfluenceNo { get; set; }
}

/// <summary>
/// 节点执行结果标签
/// </summary>
public class Tag
{
    /// <summary>
    ///  1: 通过
    ///  2：不通过
    ///  3：驳回
    /// </summary>
    public int Taged { get; set; }
    /// <summary>
    /// 用户id
    /// </summary>
    public long? UserId { get; set; }
    /// <summary>
    /// 用户名
    /// </summary>
    public string UserName { get; set; }
    /// <summary>
    /// 描述
    /// </summary>
    public string Description { get; set; }
    /// <summary>
    /// 时间
    /// </summary>
    public string TagedTime { get; set; }
}

/// <summary>
///  1: 通过
///  2：不通过
///  3：驳回
/// </summary>
public enum TagState
{
    Ok = 1,
    No = 2 ,
    Reject =3
}
