using Magic.Core;
using System;
using System.ComponentModel.DataAnnotations;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 流程管理输入参数
/// </summary>
public class FlcFlowschemeInput : InputBase
{
    public string SchemeCode { get; set; }
    public string SchemeName { get; set; }
    public string SchemeType { get; set; }
    public string SchemeVersion { get; set; }
    public string SchemeCanUser { get; set; }
    public string SchemeContent { get; set; }
    public string FrmId { get; set; }
    public FormType? FrmType { get; set; }
    public int? AuthorizeType { get; set; }
    public string OrgId { get; set; }
    public string Active { get; set; }
    public CommonStatus? Status { get; set; }
    public int? Sort { get; set; }
    public string Remark { get; set; }
}

public class AddFlcFlowschemeInput: FlcFlowschemeInput
{
}

public class DeleteFlcFlowschemeInput
{
    public string Id { get; set; }
}

public class UpdateFlcFlowschemeInput : FlcFlowschemeInput
{
    /// <summary>
    /// 流程Id
    /// </summary>
    [Required(ErrorMessage = "流程Id不能为空")]
    public string Id { get; set; }
}

public class PageFlcFlowschemeInput : FlcFlowschemeInput
{
    public string Id { get; set; }
}
