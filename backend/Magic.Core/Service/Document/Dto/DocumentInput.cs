
using Microsoft.AspNetCore.Http;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace Magic.Core.Service;

/// <summary>
/// 文档输入参数
/// </summary>
public class DocumentInput : PageInputBase
{
    /// <summary>
    /// 父Id
    /// </summary>
    public virtual long? PId { get; set; } = 0;

    /// <summary>
    /// 父ID列表
    /// </summary>
    public virtual string PIds { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public virtual string Name { get; set; }

    /// <summary>
    /// 文档类型:文件、文件夹
    /// </summary>
    public virtual DocumentType? DocumentType { get; set; }

    /// <summary>
    /// 文件后缀
    /// </summary>
    public virtual string FileSuffix { get; set; }

    /// <summary>
    /// 文件大小kb
    /// </summary>
    public virtual int? FileSizeKb { get; set; }

    /// <summary>
    /// 存储后的文件名
    /// </summary>
    public virtual string FileObjectName { get; set; }

    /// <summary>
    /// 标签
    /// </summary>
    public virtual int? Label { get; set; }

    /// <summary>
    /// 备注
    /// </summary>
    public virtual string Remark { get; set; }

    /// <summary>
    /// 创建开始时间
    /// </summary>
    public DateTime? CreateTimeStart { get; set; }

    /// <summary>
    /// 创建结束时间
    /// </summary>
    public DateTime? CreateTimeEnd { get; set; }

    /// <summary>
    /// 修改结束时间
    /// </summary>
    public DateTime? UpdateTimeStart { get; set; }

    /// <summary>
    /// 修改结束时间
    /// </summary>
    public DateTime? UpdateTimeEnd { get; set; }

    /// <summary>
    /// 文件类型
    /// </summary>
    public string FileType { get; set; }

    /// <summary>
    /// 是否删除
    /// </summary>
    public bool IsDelete = false;

}

public class AddDocumentInput : DocumentInput
{

}

/// <summary>
/// 上传文件输入参数
/// </summary>
public class DocumentUploadInput : DocumentInput
{

    public List<IFormFile> Files { get; set; }
}

public class DeleteDocumentInput
{
    /// <summary>
    /// Id
    /// </summary>
    [Required(ErrorMessage = "Id不能为空")]
    public long Id { get; set; }

}


/// <summary>
/// 批量删除入参
/// </summary>
public class DeletesDocumentInput
{
    /// <summary>
    /// Id列表
    /// </summary>
    [Required(ErrorMessage = "Id列表不能为空")]
    public List<long>? Ids { get; set; }

}

/// <summary>
/// 移动入参
/// </summary>
public class MoveDocumentInput
{
    /// <summary>
    /// Id列表
    /// </summary>
    [Required(ErrorMessage = "Id列表不能为空")]
    public List<long>? Ids { get; set; }

    /// <summary>
    /// 父Id
    /// </summary>
    public long? PId { get; set; }

}


public class UpdateDocumentInput : DocumentInput, IValidatableObject
{
    /// <summary>
    /// Id
    /// </summary>
    [Required(ErrorMessage = "Id不能为空")]
    public long? Id { get; set; }

    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (Name.Split(".").Length > 1)
        {
            yield return new ValidationResult(
                "名称不能带'.'"
                , new[] { nameof(Name) }
            );
        }
    }
}

public class QueryeDocumentInput : DeleteDocumentInput
{

}
