using Magic.Core;
using System.ComponentModel.DataAnnotations;

namespace Magic.FlowCenter.Service;

/// <summary>
/// 组织机构参数
/// </summary>
public class FlcFormInput : InputBase
{
    /// <summary>
    /// 组织Id
    /// </summary>
    public string OrgId { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public virtual string Name { get; set; }

    /// <summary>
    /// 排序
    /// </summary>
    public int? Sort { get; set; }

    /// <summary>
    /// 备注
    /// </summary>
    public string Remark { get; set; }

    /// <summary>
    /// 状态（字典 0正常 1停用 2删除）
    /// </summary>
    public CommonStatus? Status { get; set; }
    public string ContentData { get; set; }
    public string ContentParse { get; set; }
    public string Content { get; set; }
    public int? Fields { get; set; }
    public string WebId { get; set; }
    public FormType? FrmType { get; set; }
}

	public class AddFlcFormInput : FlcFormInput
{
    /// <summary>
    /// 名称
    /// </summary>
    [Required(ErrorMessage = "表单名称不能为空")]
    public override string Name { get; set; }
}

public class DeleteFlcFormInput
{
    /// <summary>
    /// 机构Id
    /// </summary>
    [Required(ErrorMessage = "表单Id不能为空")]
    public string Id { get; set; }
}

public class UpdateFlcFormInput : FlcFormInput
{
    /// <summary>
    /// 机构Id
    /// </summary>
    [Required(ErrorMessage = "表单Id不能为空")]
    public string Id { get; set; }
}

public class QueryFlcFormInput : DeleteFlcFormInput
{

}

public class PageFlcFormInput : FlcFormInput
{
    public string Id { get; set; }
}
