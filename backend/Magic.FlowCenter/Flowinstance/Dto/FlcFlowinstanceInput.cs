using Magic.Core;
using System;
using System.ComponentModel.DataAnnotations;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 工作流输入参数
/// </summary>
public class FlcFlowinstanceInput : PageInputBase
{
    /// <summary>
    /// InstanceSchemeId
    /// </summary>
    public virtual long? InstanceSchemeId { get; set; }
    
    /// <summary>
    /// Code
    /// </summary>
    public virtual string Code { get; set; }
    
    /// <summary>
    /// CustomName
    /// </summary>
    public virtual string CustomName { get; set; }
    
    /// <summary>
    /// ActivityId
    /// </summary>
    public virtual string ActivityId { get; set; }
    
    /// <summary>
    /// ActivityType
    /// </summary>
    public virtual long? ActivityType { get; set; }
    
    /// <summary>
    /// ActivityName
    /// </summary>
    public virtual string ActivityName { get; set; }
    
    /// <summary>
    /// PreviousId
    /// </summary>
    public virtual string PreviousId { get; set; }
    
    /// <summary>
    /// SchemeContent
    /// </summary>
    public virtual string SchemeContent { get; set; }
    
    /// <summary>
    /// SchemeId
    /// </summary>
    public virtual long? SchemeId { get; set; }
    
    /// <summary>
    /// DbName
    /// </summary>
    public virtual string DbName { get; set; }
    
    /// <summary>
    /// FrmData
    /// </summary>
    public virtual string FrmData { get; set; }

    /// <summary>
    /// FrmType
    /// </summary>
    public virtual FormType? FrmType { get; set; }

    /// <summary>
    /// FrmContentData
    /// </summary>
    public virtual string FrmContentData { get; set; }
    
    /// <summary>
    /// FrmContentParse
    /// </summary>
    public virtual string FrmContentParse { get; set; }
    
    /// <summary>
    /// FrmId
    /// </summary>
    public virtual long? FrmId { get; set; }
    
    /// <summary>
    /// SchemeType
    /// </summary>
    public virtual string SchemeType { get; set; }
    
    /// <summary>
    /// FlowLevel
    /// </summary>
    public virtual long? FlowLevel { get; set; }
    
    /// <summary>
    /// IsFinish
    /// </summary>
    public virtual long? IsFinish { get; set; }
    
    /// <summary>
    /// FrmContent
    /// </summary>
    public virtual string FrmContent { get; set; }
    
    /// <summary>
    /// MakerList
    /// </summary>
    public virtual string MakerList { get; set; }
    
    /// <summary>
    /// OrgId
    /// </summary>
    public virtual long? OrgId { get; set; }
    
    /// <summary>
    /// Active
    /// </summary>
    public virtual string Active { get; set; }
    
    /// <summary>
    /// Remark
    /// </summary>
    public virtual string Remark { get; set; }

    public virtual CommonStatus Status { get; set; } = CommonStatus.ENABLE;
    public virtual int LookType { get; set; } = 0;

}

public class AddFlcFlowinstanceInput : FlcFlowinstanceInput
{
}

public class DeleteFlcFlowinstanceInput
{
    /// <summary>
    /// Id
    /// </summary>
    [Required(ErrorMessage = "Id不能为空")]
    public long Id { get; set; }
    
}

public class UpdateFlcFlowinstanceInput : FlcFlowinstanceInput
{
    /// <summary>
    /// Id
    /// </summary>
    [Required(ErrorMessage = "Id不能为空")]
    public long Id { get; set; }
    
}

public class QueryeFlcFlowinstanceInput : DeleteFlcFlowinstanceInput
{

}
