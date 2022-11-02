﻿using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysUserService
{
    Task AddUser(AddUserInput input);
    Task ChangeUserStatus(UpdateUserInput input);
    Task DeleteUser(DeleteUserInput input);
    Task<IActionResult> ExportUser([FromQuery] UserInput input);
    Task ImportUser(IFormFile file);
    Task<dynamic> GetUser([FromQuery] QueryUserInput input);
    Task<dynamic> GetUserById(long userId);
    Task<List<long>> GetUserDataScopeIdList(long userId = 0);
    Task<dynamic> GetUserOwnData([FromQuery] QueryUserInput input);
    Task<dynamic> GetUserOwnRole([FromQuery] QueryUserInput input);
    Task<dynamic> GetUserSelector([FromQuery] UserInput input);
    Task GrantUserData(UpdateUserInput input);
    Task GrantUserRole(UpdateUserInput input);
    Task<dynamic> QueryUserPageList([FromQuery] UserInput input);
    Task ResetUserPwd(QueryUserInput input);
    Task SaveAuthUserToUser(AuthUserInput authUser, UserInput sysUser);
    Task UpdateAvatar(UploadAvatarInput input);
    Task UpdateUser(UpdateUserInput input);
    Task UpdateUserInfo(UpdateUserInput input);
    Task UpdateUserPwd(ChangePasswordUserInput input);
    Task<List<long>> GetDataScopeIdUserList(long userId = 0);
    void CheckDataScopeByUserId(long userId);
    void CheckDataScope(long orgId);
}
