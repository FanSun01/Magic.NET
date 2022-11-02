using System;

namespace Magic.Core;

/// <summary>
/// 启用用操作日志
/// </summary>
[AttributeUsage(AttributeTargets.Class | AttributeTargets.Method | AttributeTargets.Property)]
    public class OpLogAttribute : Attribute
    {

    }
