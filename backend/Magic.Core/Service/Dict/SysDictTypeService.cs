

using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 字典类型服务
/// </summary>
[ApiDescriptionSettings(Name = "DictType", Order = 100)]
public class SysDictTypeService : ISysDictTypeService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysDictType> _sysDictTypeRep;  // 字典类型表仓储   
    private readonly ISysDictDataService _sysDictDataService;

    public SysDictTypeService(ISysDictDataService sysDictDataService,
                              SqlSugarRepository<SysDictType> sysDictTypeRep)
    {
        _sysDictDataService = sysDictDataService;
        _sysDictTypeRep = sysDictTypeRep;
    }

    /// <summary>
    /// 分页查询字典类型
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysDictType/page")]
    public async Task<dynamic> QueryDictTypePageList([FromQuery] DictTypeInput input)
    {
        var dictTypes = await _sysDictTypeRep.AsQueryable()
             .WhereIF(!string.IsNullOrWhiteSpace(input.Code), u => u.Code.Contains(input.Code.Trim()))
             .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
             .Where(u => u.Status != CommonStatus.DELETED).OrderBy(u => u.Sort)
             .ToPagedListAsync(input.PageNo, input.PageSize);
        return dictTypes.XnPagedResult();
    }

    /// <summary>
    /// 获取字典类型列表
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysDictType/list")]
    public async Task<dynamic> GetDictTypeList()
    {
        return await _sysDictTypeRep.Where(u => u.Status != CommonStatus.DELETED).ToListAsync();
    }

    /// <summary>
    /// 获取字典类型下所有字典值
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [AllowAnonymous]
    [HttpGet("/sysDictType/dropDown")]
    public async Task<dynamic> GetDictTypeDropDown([FromQuery] DropDownDictTypeInput input)
    {
        var dictType = await _sysDictTypeRep.FirstOrDefaultAsync(u => u.Code == input.Code);
        if (dictType == null) throw Oops.Oh(ErrorCode.D3000);
        return await _sysDictDataService.GetDictDataListByDictTypeId(dictType.Id);
    }

    /// <summary>
    /// 添加字典类型
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictType/add")]
    public async Task AddDictType(AddDictTypeInput input)
    {
        var isExist = await _sysDictTypeRep.AnyAsync(u => u.Name == input.Name || u.Code == input.Code);
        if (isExist) throw Oops.Oh(ErrorCode.D3001);

        var dictType = input.Adapt<SysDictType>();
        var typeId = (await _sysDictTypeRep.InsertReturnEntityAsync(dictType)).Id;
        if (input.DictDataList != null && input.DictDataList.Any()) {
            foreach (var item in input.DictDataList)
            {
                item.TypeId= typeId;
                await _sysDictDataService.AddDictData(item);
            }
        }
    }

    /// <summary>
    /// 删除字典类型
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictType/delete")]
    public async Task DeleteDictType(DeleteDictTypeInput input)
    {
        var dictType = await _sysDictTypeRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (dictType == null) throw Oops.Oh(ErrorCode.D3000);
        await _sysDictTypeRep.DeleteAsync(dictType);
        await _sysDictDataService.DeleteByTypeId(input.Id);
    }

    /// <summary>
    /// 更新字典类型
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictType/edit"),]
    public async Task UpdateDictType(UpdateDictTypeInput input)
    {
        var isExist = await _sysDictTypeRep.AnyAsync(u => u.Id == input.Id);
        if (!isExist) throw Oops.Oh(ErrorCode.D3000);

        // 排除自己并且判断与其他是否相同
        isExist = await _sysDictTypeRep.AnyAsync(u => (u.Name == input.Name || u.Code == input.Code) && u.Id != input.Id);
        if (isExist) throw Oops.Oh(ErrorCode.D3001);

        var dictType = input.Adapt<SysDictType>();
        await _sysDictTypeRep.AsUpdateable(dictType).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 字典类型详情
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysDictType/detail")]
    public async Task<dynamic> GetDictType([FromQuery] QueryDictTypeInfoInput input)
    {
        return await _sysDictTypeRep.FirstOrDefaultAsync(u => u.Id == input.Id);
    }

    /// <summary>
    /// 更新字典类型状态
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictType/changeStatus")]
    public async Task ChangeDictTypeStatus(UpdateDictTypeInput input)
    {
        var dictType = await _sysDictTypeRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (dictType == null) throw Oops.Oh(ErrorCode.D3000);

        if (!Enum.IsDefined(typeof(CommonStatus), input.Status))
            throw Oops.Oh(ErrorCode.D3005);
        dictType.Status = input.Status;
        await _sysDictTypeRep.AsUpdateable(dictType).ExecuteCommandAsync();
    }

    /// <summary>
    /// 字典类型与字典值构造的字典树
    /// </summary>
    /// <returns></returns>
    [AllowAnonymous]
    [HttpGet("/sysDictType/tree")]
    public async Task<List<DictTreeOutput>> GetDictTree()
    {
        List<SysDictType> typeList = await GetDictTypeList();
        List<SysDictData> dataList = await _sysDictDataService.GetDictDataList(new QueryDictDataListInput());

        List<DictTreeOutput> list = new List<DictTreeOutput>();

        foreach (var item in typeList)
        {
            list.Add(new DictTreeOutput
            {
                Id = item.Id,
                Code = item.Code,
                Name = item.Name,
                Children = dataList.Where(m => m.TypeId == item.Id).Select(m => new DictTreeOutput
                {
                    Id = m.Id,
                    Pid = m.TypeId,
                    Code = m.Code,
                    Name = m.Value
                }).ToList()
            });
        }
        return list;
    }
}
