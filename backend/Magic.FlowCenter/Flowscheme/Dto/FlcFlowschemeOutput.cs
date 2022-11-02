using System;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 流程管理输出参数
/// </summary>
public class FlcFlowschemeOutput:FlcFlowschemeInput
{
    /// <summary>
    /// 流程Id
    /// </summary>
    public string Id { get; set; }
    public int? Fields { get; set; }
    public string Name { get; set; }
    public string WebId { get; set; }
    public string ContentData { get; set; }
    public string ContentParse { get; set; }
    public string Content { get; set; }
    /// <summary>
    /// 如果下个执行节点是运行时指定执行者。需要传指定的类型
    /// <para>取值为RUNTIME_SPECIAL_ROLE、RUNTIME_SPECIAL_USER</para>
    /// </summary>
    public string NextNodeDesignateType { get; set; }

    /// <summary>
    /// 如果下个执行节点是运行时指定执行者。该值表示具体的执行者
    /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_ROLE，则该值为指定的角色</para>
    /// <para>如果NodeDesignateType为RUNTIME_SPECIAL_USER，则该值为指定的用户</para>
    /// </summary>
    public string[] NextNodeDesignates { get; set; }
    public string NextMakerName { get; set; }
}
