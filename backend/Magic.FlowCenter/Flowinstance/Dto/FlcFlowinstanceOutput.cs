using Magic.Core;
using Magic.FlowCenter.Entity;
using System.Collections.Generic;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 工作流输出参数
/// </summary>
public class FlcFlowinstanceOutput:FlcFlowinstance
    {
	public string WebId { get; set; }
        public List<FlcFlowInstanceOperationHistory> hisList { get; set; }

    }
