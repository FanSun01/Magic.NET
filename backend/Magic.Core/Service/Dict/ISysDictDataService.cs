﻿using Magic.Core.Entity;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysDictDataService
{
    Task AddDictData(AddDictDataInput input);
    Task ChangeDictDataStatus(UpdateDictDataInput input);
    Task DeleteByTypeId(long dictTypeId);
    Task DeleteDictData(DeleteDictDataInput input);
    Task<dynamic> GetDictData([FromQuery] QueryDictDataInput input);
    Task<dynamic> GetDictDataList([FromQuery] QueryDictDataListInput input);
    Task<dynamic> GetDictDataListByDictTypeId(long dictTypeId);
    Task<dynamic> QueryDictDataPageList([FromQuery] DictDataInput input);
    Task UpdateDictData(UpdateDictDataInput input);
    Task<List<SysDictData>> GetDictDataByCode(string code);
}
