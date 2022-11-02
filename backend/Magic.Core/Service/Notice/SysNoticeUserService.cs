

using Furion.DependencyInjection;
using Magic.Core.Entity;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 通知公告用户
/// </summary>
public class SysNoticeUserService : ISysNoticeUserService, ITransient
{
    private readonly SqlSugarRepository<SysNoticeUser> _sysNoticeUserRep;  // 通知公告用户表仓储 
  
    public SysNoticeUserService(SqlSugarRepository<SysNoticeUser> sysNoticeUserRep)
    {
        _sysNoticeUserRep = sysNoticeUserRep;
    }

    /// <summary>
    /// 增加
    /// </summary>
    /// <param name="noticeId"></param>
    /// <param name="noticeUserIdList"></param>
    /// <param name="noticeUserStatus"></param>
    /// <returns></returns>
    public async Task Add(long noticeId, List<long> noticeUserIdList, NoticeUserStatus noticeUserStatus)
    {
        List<SysNoticeUser> list = new List<SysNoticeUser>();
        noticeUserIdList.ForEach(u =>
        {
            list.Add(new SysNoticeUser
            {
                NoticeId = noticeId,
                UserId = u,
                ReadStatus = noticeUserStatus
            });
        });
        await _sysNoticeUserRep.InsertAsync(list);
    }

    /// <summary>
    /// 更新
    /// </summary>
    /// <param name="noticeId"></param>
    /// <param name="noticeUserIdList"></param>
    /// <param name="noticeUserStatus"></param>
    /// <returns></returns>
    public async Task Update(long noticeId, List<long> noticeUserIdList, NoticeUserStatus noticeUserStatus)
    {
        await _sysNoticeUserRep.DeleteAsync(u => u.NoticeId == noticeId);

        await Add(noticeId, noticeUserIdList, noticeUserStatus);
    }

    /// <summary>
    /// 获取通知公告用户列表
    /// </summary>
    /// <param name="noticeId"></param>
    /// <returns></returns>
    public async Task<List<SysNoticeUser>> GetNoticeUserListByNoticeId(long noticeId)
    {
        return await _sysNoticeUserRep.Where(u => u.NoticeId == noticeId).ToListAsync();
    }

    /// <summary>
    /// 设置通知公告读取状态
    /// </summary>
    /// <param name="noticeId"></param>
    /// <param name="userId"></param>
    /// <param name="status"></param>
    /// <returns></returns>
    public async Task Read(long noticeId, long userId, NoticeUserStatus status)
    {
        await _sysNoticeUserRep.UpdateAsync(m => m.NoticeId == noticeId && m.UserId == userId, m => new SysNoticeUser
        {
            ReadStatus = status,
            ReadTime = DateTime.Now
        });
    }
}
