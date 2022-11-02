using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface IAuthService
{
    Task<dynamic> GetCaptcha();
    Task<bool> GetCaptchaOpen();
    Task<LoginOutput> GetLoginUserAsync();
    Task<string> LoginAsync([Required] LoginInput input);
    Task LogoutAsync();
    Task<dynamic> VerificationCode(ClickWordCaptchaInput input);

    Task<string> SimulationLoginAsync([Required] LoginInput input);
}
