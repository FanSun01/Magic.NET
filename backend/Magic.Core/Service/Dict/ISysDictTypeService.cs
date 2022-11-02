﻿using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface ISysDictTypeService
{
    Task AddDictType(AddDictTypeInput input);
    Task ChangeDictTypeStatus(UpdateDictTypeInput input);
    Task DeleteDictType(DeleteDictTypeInput input);
    Task<List<DictTreeOutput>> GetDictTree();
    Task<dynamic> GetDictType([FromQuery] QueryDictTypeInfoInput input);
    Task<dynamic> GetDictTypeDropDown([FromQuery] DropDownDictTypeInput input);
    Task<dynamic> GetDictTypeList();
    Task<dynamic> QueryDictTypePageList([FromQuery] DictTypeInput input);
    Task UpdateDictType(UpdateDictTypeInput input);
}
