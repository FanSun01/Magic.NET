using SqlSugar;

namespace Magic.FlowCenter.Entity;

/// <summary>
/// 自定义租户基类实体
/// </summary>
public abstract class FlcDBEntityTenant : FlcDEntityBase
{
    /// <summary>
    /// 租户id
    /// </summary>
    [SugarColumn(ColumnDescription = "租户id")]
    public virtual long? TenantId { get; set; }

    //public override void Create() {
    //    var userId = App.User.FindFirst(ClaimConst.CLAINM_USERID)?.Value;
    //    var userName = App.User.FindFirst(ClaimConst.CLAINM_ACCOUNT)?.Value;
    //    var tenantId = App.User.FindFirst(ClaimConst.TENANT_ID)?.Value;
    //    this.Id = YitIdHelper.NextId();
    //    this.CreatedTime = DateTime.Now;
        
    //    if (!string.IsNullOrEmpty(userId))
    //    {
    //        this.CreatedUserId = long.Parse(userId);
    //        this.CreatedUserName = userName;
    //    }
    //    if (!string.IsNullOrWhiteSpace(tenantId)) {
    //        this.TenantId = long.Parse(tenantId);
    //    }
    //}

    //public void CreateNotFillTenantInfo() {
    //    base.Create();
    //}
}
