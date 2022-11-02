using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 通知公告服务
/// </summary>
[ApiDescriptionSettings(Name = "Notice", Order = 100)]
public class SysNoticeService : ISysNoticeService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysNotice> _sysNoticeRep;  // 通知公告表仓储 
    private readonly ISysOnlineUserService _sysOnlineUserService;

    private readonly ISysNoticeUserService _sysNoticeUserService;
      private readonly SqlSugarRepository<SysEmp> _sysEmpRep;  

    public SysNoticeService(SqlSugarRepository<SysNotice> sysNoticeRep,
                            ISysNoticeUserService sysNoticeUserService, ISysOnlineUserService sysOnlineUserService, SqlSugarRepository<SysEmp> sysEmpRep)
    {
        _sysNoticeRep = sysNoticeRep;
        _sysNoticeUserService = sysNoticeUserService;
        _sysOnlineUserService = sysOnlineUserService;
        _sysEmpRep=sysEmpRep;
    }

    /// <summary>
    /// 分页查询通知公告
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysNotice/page")]
    public async Task<dynamic> QueryNoticePageList([FromQuery] NoticeInput input)
    {
        var notices = await _sysNoticeRep.AsQueryable()
                                        .WhereIF(!string.IsNullOrWhiteSpace(input.SearchValue), u => u.Title.Contains(input.SearchValue.Trim()) || u.Content.Contains(input.SearchValue.Trim()))
                                        .WhereIF(input.Type > 0, u => u.Type == input.Type)
                                        .Where(u => u.Status != NoticeStatus.DELETED)
                                        .ToPagedListAsync(input.PageNo, input.PageSize);
        return notices.XnPagedResult();
    }

    /// <summary>
    /// 增加通知公告
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysNotice/add")]
    public async Task AddNotice(AddNoticeInput input)
    {
        if (input.Status != NoticeStatus.DRAFT && input.Status != NoticeStatus.PUBLIC)
            throw Oops.Oh(ErrorCode.D7000);

        var notice = input.Adapt<SysNotice>();
        await UpdatePublicInfo(notice);
        // 如果是发布，则设置发布时间
        if (input.Status == NoticeStatus.PUBLIC)
            notice.PublicTime = DateTime.Now;
        var newItem =await _sysNoticeRep.InsertReturnEntityAsync(notice);

        // 通知到的人
        var noticeUserIdList = input.NoticeUserIdList;
        var noticeUserStatus = NoticeUserStatus.UNREAD;
        await _sysNoticeUserService.Add(newItem.Id, noticeUserIdList, noticeUserStatus);
        if (newItem.Status == NoticeStatus.PUBLIC) {
            await _sysOnlineUserService.PushNotice(newItem, noticeUserIdList);
        }
        
    }

    /// <summary>
    /// 删除通知公告
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysNotice/delete")]
    public async Task DeleteNotice(DeleteNoticeInput input)
    {
        var notice = await _sysNoticeRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (notice.Status != NoticeStatus.DRAFT && notice.Status != NoticeStatus.CANCEL) // 只能删除草稿和撤回的
            throw Oops.Oh(ErrorCode.D7001);

        await _sysNoticeRep.DeleteAsync(notice);
    }

    /// <summary>
    /// 更新通知公告
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysNotice/edit")]
    public async Task UpdateNotice(UpdateNoticeInput input)
    {
        if (input.Status != NoticeStatus.DRAFT && input.Status != NoticeStatus.PUBLIC)
            throw Oops.Oh(ErrorCode.D7000);

        //  非草稿状态
        if (input.Status != NoticeStatus.DRAFT)
            throw Oops.Oh(ErrorCode.D7002);

        var notice = input.Adapt<SysNotice>();
        if (input.Status == NoticeStatus.PUBLIC)
        {
            notice.PublicTime = DateTime.Now;
            await UpdatePublicInfo(notice);
        }
        await _sysNoticeRep.UpdateAsync(notice);

        // 通知到的人
        var noticeUserIdList = input.NoticeUserIdList;
        var noticeUserStatus = NoticeUserStatus.UNREAD;
        await _sysNoticeUserService.Update(input.Id, noticeUserIdList, noticeUserStatus);
        if (notice.Status == NoticeStatus.PUBLIC)
        {
            await _sysOnlineUserService.PushNotice(notice, noticeUserIdList);
        }
    }

    /// <summary>
    /// 获取通知公告详情
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysNotice/detail")]
    public async Task<NoticeDetailOutput> GetNotice([FromQuery] QueryNoticeInput input)
    {
        var notice = await _sysNoticeRep.FirstOrDefaultAsync(u => u.Id == input.Id);

        // 获取通知到的用户
        var noticeUserList = await _sysNoticeUserService.GetNoticeUserListByNoticeId(input.Id);
        var noticeUserIdList = new List<string>();
        var noticeUserReadInfoList = new List<NoticeUserRead>();
        if (noticeUserList != null)
        {
            noticeUserList.ForEach(u =>
            {
                noticeUserIdList.Add(u.UserId.ToString());
                var noticeUserRead = new NoticeUserRead
                {
                    UserId = u.UserId,
                    UserName = UserManager.Name,
                    ReadStatus = u.ReadStatus,
                    ReadTime = u.ReadTime
                };
                noticeUserReadInfoList.Add(noticeUserRead);
            });
        }
        var noticeResult = notice.Adapt<NoticeDetailOutput>();
        noticeResult.NoticeUserIdList = noticeUserIdList;
        noticeResult.NoticeUserReadInfoList = noticeUserReadInfoList;
        // 如果该条通知公告为已发布，则将当前用户的该条通知公告设置为已读
        if (notice.Status == NoticeStatus.PUBLIC)
            await _sysNoticeUserService.Read(notice.Id, UserManager.UserId, NoticeUserStatus.READ);
        return noticeResult;
    }

    /// <summary>
    /// 修改通知公告状态
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysNotice/changeStatus")]
    public async Task ChangeStatus(ChangeStatusNoticeInput input)
    {
        // 状态应为撤回或删除或发布
        if (input.Status != NoticeStatus.CANCEL && input.Status != NoticeStatus.DELETED && input.Status != NoticeStatus.PUBLIC)
            throw Oops.Oh(ErrorCode.D7000);

        var notice = await _sysNoticeRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        notice.Status = input.Status;

        if (input.Status == NoticeStatus.CANCEL)
        {
            notice.CancelTime = DateTime.Now;
        }
        else if (input.Status == NoticeStatus.PUBLIC)
        {
            notice.PublicTime = DateTime.Now;
        }
        await _sysNoticeRep.UpdateAsync(notice);
        if (notice.Status == NoticeStatus.PUBLIC)
        {
            // 获取通知到的用户
            var noticeUserList = await _sysNoticeUserService.GetNoticeUserListByNoticeId(input.Id);
            await _sysOnlineUserService.PushNotice(notice, noticeUserList.Select(m => m.UserId).ToList());
        }
    }

    /// <summary>
    /// 获取接收的通知公告
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysNotice/received")]
    public async Task<dynamic> ReceivedNoticePageList([FromQuery] NoticeInput input)
    {
        var notices = await _sysNoticeRep.AsQueryable().InnerJoin<SysNoticeUser>((n, u) => n.Id == u.NoticeId)
          .Where((n, u) => u.UserId == UserManager.UserId)
          .WhereIF(!string.IsNullOrWhiteSpace(input.SearchValue), n => n.Title.Contains(input.SearchValue.Trim()) || n.Content.Contains(input.SearchValue.Trim()))
          .WhereIF(input.Type > 0, (n, u) => n.Type == input.Type)
          .Select<NoticeReceiveOutput>()
          .ToPagedListAsync(input.PageNo, input.PageSize);
        return notices.XnPagedResult();
    }

    /// <summary>
    /// 未处理消息
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysNotice/unread")]
    public async Task<dynamic> UnReadNoticeList([FromQuery] NoticeInput input) {
        var dic = typeof(NoticeType).EnumToList();
		var notices = await _sysNoticeRep.AsQueryable().InnerJoin<SysNoticeUser>((n, u) => n.Id == u.NoticeId)
		 .Where((n, u) => u.UserId == UserManager.UserId && u.ReadStatus== NoticeUserStatus.UNREAD).PartitionBy(n => n.Type).OrderBy(n=>n.CreatedTime,OrderByType.Desc).Take(input.PageSize).Select<NoticeReceiveOutput>()
         .ToListAsync();
        var count = await _sysNoticeRep.AsQueryable().InnerJoin<SysNoticeUser>((n, u) => n.Id == u.NoticeId).Where((n, u) => u.UserId == UserManager.UserId && u.ReadStatus == NoticeUserStatus.UNREAD).CountAsync();

        List<dynamic> noticeClays = new List<dynamic>();
        int index = 0;
        foreach (var item in dic)
        {
            noticeClays.Add(
                new
                {
                    Index= index++,
                    Key = item.Describe,
                    Value = item.Value,
                    NoticeData = notices.Where(m => m.Type == item.Value).ToList()
                }
            );
        }
        return new
        {
            Rows = noticeClays,
            TotalRows = count
        };
    }

    /// <summary>
    /// 更新发布信息
    /// </summary>
    /// <param name="notice"></param>
    [NonAction]
    private async Task UpdatePublicInfo(SysNotice notice)
    {
        var emp = await _sysEmpRep.FirstOrDefaultAsync(u => u.Id == UserManager.UserId);
        notice.PublicUserId = UserManager.UserId;
        notice.PublicUserName = UserManager.Name;
        notice.PublicOrgId = emp.OrgId;
        notice.PublicOrgName = emp.OrgName;
    }
}
