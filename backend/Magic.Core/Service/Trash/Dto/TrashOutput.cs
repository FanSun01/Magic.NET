using System;

namespace Magic.Core.Service;

/// <summary>
/// 回收站输出参数
/// </summary>
public class TrashOutput
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
    public string PIds { get; set; }
    
    /// <summary>
    /// 名称
    /// </summary>
    public string Name { get; set; }
    
    /// <summary>
    /// 类型
    /// </summary>
    public int DocumentType { get; set; }
    
    /// <summary>
    /// 文件后缀
    /// </summary>
    public string FileSuffix { get; set; }
    
    /// <summary>
    /// 文件大小kb
    /// </summary>
    public int FileSizeKb { get; set; }
    
    /// <summary>
    /// 存储后的文件名
    /// </summary>
    public string FileObjectName { get; set; }
    
    /// <summary>
    /// 标签
    /// </summary>
    public int Label { get; set; }
    
    /// <summary>
    /// 备注
    /// </summary>
    public string Remark { get; set; }
    
}
