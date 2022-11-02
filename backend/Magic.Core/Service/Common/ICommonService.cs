using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ICommonService
{
   Task<IEnumerable<EntityInfo>> GetEntityInfos(bool IsCache=true);
}
