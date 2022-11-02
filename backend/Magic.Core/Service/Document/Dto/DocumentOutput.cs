using System;
using System.Collections.Generic;

namespace Magic.Core.Service;

/// <summary>
/// 文档输出参数
/// </summary>
public class DocumentOutput
{
    /// <summary>
    /// Id
    /// </summary>
    public long Id { get; set; }

    /// <summary>
    /// 父Id
    /// </summary>
    public long PId { get; set; }

    /// <summary>
    /// 父ID列表
    /// </summary>
    //public string PIds { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public string Name { get; set; }

    /// <summary>
    /// 文档类型:文件、文件夹
    /// </summary>
    public DocumentType DocumentType { get; set; }


    /// <summary>
    /// 文件类型
    /// </summary>
    public string FileType { get; set; }

    /// <summary>
    /// 文件后缀
    /// </summary>
    public string FileSuffix { get; set; }

    /// <summary>
    /// 文件大小kb
    /// </summary>
    public int? FileSizeKb { get; set; }

    /// <summary>
    /// 文件大小kb
    /// </summary>
    public string FileSize { get; set; }

    /// <summary>
    /// 存储后的文件名
    /// </summary>
    //public string FileObjectName { get; set; }

    /// <summary>
    /// 标签
    /// </summary>
    public int? Label { get; set; }

    /// <summary>
    /// 标签数组
    /// </summary>
    public string[] Tags { get; set; }

    /// <summary>
    /// 备注
    /// </summary>
    public string Remark { get; set; }

    /// <summary>
    /// 创建时间 
    ///</summary>

    public DateTime? CreatedTime { get; set; }
    /// <summary>
    /// 更新时间 
    ///</summary>

    public DateTime? UpdatedTime { get; set; }
    /// <summary>
    /// 创建用户ID 
    ///</summary>
    public long? CreatedUserId { get; set; }
    /// <summary>
    /// 创建人用户名 
    ///</summary>
    public string CreatedUserName { get; set; }
    /// <summary>
    /// 修改人ID 
    ///</summary>
    public long? UpdatedUserId { get; set; }

    /// <summary>
    /// 修改人用户名 
    ///</summary>
    public string UpdatedUserName { get; set; }


}

/// <summary>
/// 树查询输出
/// </summary>
public class DocumentTreeOutPut
{
    /// <summary>
    /// Id
    /// </summary>
    public long Id { get; set; }

    /// <summary>
    /// 父Id
    /// </summary>
    public long PId { get; set; }

    /// <summary>
    /// 父ID列表
    /// </summary>
    //public string PIds { get; set; }

    /// <summary>
    /// 名称
    /// </summary>
    public string Name { get; set; }

    public List<DocumentTreeOutPut> Children { get; set; }
}
