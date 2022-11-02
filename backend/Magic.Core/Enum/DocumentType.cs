using System.ComponentModel;

namespace Magic.Core;

/// <summary>
/// 文档类型
/// </summary>
public enum DocumentType
{
    /// <summary>
    /// 文件夹
    /// </summary>
    [Description("文件夹")]
    Folder = 1,

    /// <summary>
    /// 文件
    /// </summary>
    [Description("文件")]
    File = 2,

}
