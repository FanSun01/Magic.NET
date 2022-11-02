using SqlSugar;
using System;
using System.ComponentModel.DataAnnotations;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 自定义实体基类
/// </summary>
[Tenant("1")]
public abstract class FlcDEntityBase : PrimaryKeyEntity
{
    /// <summary>
    /// 创建时间
    /// </summary>
    [SugarColumn(ColumnDescription = "创建时间")]
    public virtual DateTime? CreatedTime { get; set; }

    /// <summary>
    /// 更新时间
    /// </summary>
    [SugarColumn(ColumnDescription = "更新时间")]
    public virtual DateTime? UpdatedTime { get; set; }

    /// <summary>
    /// 创建者Id
    /// </summary>
    [SugarColumn(ColumnDescription = "创建者Id")]
    public virtual long? CreatedUserId { get; set; }

    /// <summary>
    /// 创建者名称
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "创建者名称")]
    public virtual string CreatedUserName { get; set; }

    /// <summary>
    /// 修改者Id
    /// </summary>
    [SugarColumn(ColumnDescription = "修改者Id")]
    public virtual long? UpdatedUserId { get; set; }

    /// <summary>
    /// 修改者名称
    /// </summary>
    [MaxLength(20)]
    [SugarColumn(ColumnDescription = "修改者名称")]
    public virtual string UpdatedUserName { get; set; }

    /// <summary>
    /// 软删除
    /// </summary>
    [SugarColumn(ColumnDescription = "软删除")]
    public virtual bool IsDeleted { get; set; } = false;


    //public virtual void Create()
    //{
    //    var userId = App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value;
    //    var userName = App.User.FindFirst(ClaimConst.CLAINM_ACCOUNT)?.Value;
    //    Id = YitIdHelper.NextId();
    //    CreatedTime = DateTime.Now;
    //    if (!string.IsNullOrEmpty(userId))
    //    {
    //        CreatedUserId = long.Parse(userId);
    //        CreatedUserName = userName;
    //    }
    //}

    //public void Modify()
    //{
    //    var userId = App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value;
    //    var userName = App.User.FindFirst(ClaimConst.CLAINM_ACCOUNT)?.Value;
    //    UpdatedTime = DateTime.Now;
    //    if (!string.IsNullOrEmpty(userId))
    //    {
    //        UpdatedUserId = long.Parse(userId);
    //        UpdatedUserName = userName;
    //    }
    //}

    /// <summary>
    /// 更新信息列
    /// </summary>
    /// <returns></returns>
    public virtual string[] UpdateColumn()
    {
        var result = new[] {nameof(UpdatedUserId), nameof(UpdatedUserName), nameof(UpdatedTime)};
        return result;
    }

    /// <summary>
    /// 假删除的列，包含更新信息
    /// </summary>
    /// <returns></returns>
    public virtual string[] FalseDeleteColumn()
    {
        var updateColumn = UpdateColumn();
        var deleteColumn = new[] {nameof(IsDeleted)};
        var result = new string [updateColumn.Length + deleteColumn.Length];
        deleteColumn.CopyTo(result, 0);
        updateColumn.CopyTo(result, deleteColumn.Length);
        return result;
    }
}

/// <summary>
/// 递增主键实体基类
/// </summary>
public abstract class AutoIncrementEntity
{
    /// <summary>
    /// 主键Id
    /// </summary>
    [SugarColumn(IsIdentity = true, ColumnDescription = "Id主键", IsPrimaryKey = true)] //通过特性设置主键和自增列 
    // 注意是在这里定义你的公共实体
    public virtual int Id { get; set; }
}

/// <summary>
/// 主键实体基类
/// </summary>
public abstract class PrimaryKeyEntity
{
    /// <summary>
    /// 主键Id
    /// </summary>
    [SugarColumn(ColumnDescription = "Id主键", IsPrimaryKey = true)]
    // 注意是在这里定义你的公共实体
    public virtual long Id { get; set; }
}
