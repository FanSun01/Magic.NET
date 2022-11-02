using System;
using Magic.Core;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 工作流输出参数
/// </summary>
public class FlcFlowinstanceDto
{
    /// <summary>
    /// Id
    /// </summary>
    public long Id { get; set; }
    
    /// <summary>
    /// InstanceSchemeId
    /// </summary>
    public long InstanceSchemeId { get; set; }
    
    /// <summary>
    /// Code
    /// </summary>
    public string Code { get; set; }
    
    /// <summary>
    /// CustomName
    /// </summary>
    public string CustomName { get; set; }
    
    /// <summary>
    /// ActivityId
    /// </summary>
    public string ActivityId { get; set; }
    
    /// <summary>
    /// ActivityType
    /// </summary>
    public long ActivityType { get; set; }
    
    /// <summary>
    /// ActivityName
    /// </summary>
    public string ActivityName { get; set; }
    
    /// <summary>
    /// PreviousId
    /// </summary>
    public string PreviousId { get; set; }
    
    /// <summary>
    /// SchemeContent
    /// </summary>
    public string SchemeContent { get; set; }
    
    /// <summary>
    /// SchemeId
    /// </summary>
    public long SchemeId { get; set; }
    
    /// <summary>
    /// DbName
    /// </summary>
    public string DbName { get; set; }
    
    /// <summary>
    /// FrmData
    /// </summary>
    public string FrmData { get; set; }

    /// <summary>
    /// FrmType
    /// </summary>
    public FormType FrmType { get; set; } = FormType.CUSTOMFORM;

    /// <summary>
    /// FrmContentData
    /// </summary>
    public string FrmContentData { get; set; }
    
    /// <summary>
    /// FrmContentParse
    /// </summary>
    public string FrmContentParse { get; set; }
    
    /// <summary>
    /// FrmId
    /// </summary>
    public long FrmId { get; set; }
    
    /// <summary>
    /// SchemeType
    /// </summary>
    public string SchemeType { get; set; }
    
    /// <summary>
    /// FlowLevel
    /// </summary>
    public long FlowLevel { get; set; }
    
    /// <summary>
    /// IsFinish
    /// </summary>
    public bool IsFinish { get; set; }
    
    /// <summary>
    /// FrmContent
    /// </summary>
    public string FrmContent { get; set; }
    
    /// <summary>
    /// MakerList
    /// </summary>
    public string MakerList { get; set; }
    
    /// <summary>
    /// OrgId
    /// </summary>
    public long OrgId { get; set; }
    
    /// <summary>
    /// Active
    /// </summary>
    public string Active { get; set; }
    
    /// <summary>
    /// Remark
    /// </summary>
    public string Remark { get; set; }

    public CommonStatus Status { get; set; } = CommonStatus.ENABLE;

}
