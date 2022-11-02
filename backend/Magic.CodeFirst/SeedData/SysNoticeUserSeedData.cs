using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysNoticeUserSeedData : ISeedData , ISqlSugarEntitySeedData<SysNoticeUser>
{  public IEnumerable<SysNoticeUser> HasData()
    {  string json = @"[{""NoticeId"":179794426552389,""UserId"":177325484421189,""ReadTime"":""2021-07-12T11:40:09.753"",""ReadStatus"":1},{""NoticeId"":179794551148613,""UserId"":177325484421189,""ReadTime"":""2021-07-12T11:40:13.633"",""ReadStatus"":1},{""NoticeId"":179798127382597,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179798369882181,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179799297638469,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179799792885829,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179799966392389,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179800281276485,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179803119427653,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179803196371013,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179803415650373,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179826348257349,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179801393012805,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179801499226181,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":179801551765573,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0},{""NoticeId"":193416668713029,""UserId"":177325484421189,""ReadTime"":""1753-01-01T00:00:00"",""ReadStatus"":0}]
";
 List<SysNoticeUser> list = JsonUtil.ToObject<List<SysNoticeUser>>(json);

        return list;
}}
