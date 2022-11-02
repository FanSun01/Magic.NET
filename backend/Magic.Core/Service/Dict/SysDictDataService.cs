

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
/// 字典值服务
/// </summary>
[ApiDescriptionSettings(Name = "DictData", Order = 100)]
public class SysDictDataService : ISysDictDataService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysDictData> _sysDictDataRep;  // 字典类型表仓储 

    public SysDictDataService(SqlSugarRepository<SysDictData> sysDictDataRep)
    {
        _sysDictDataRep = sysDictDataRep;
    }

    /// <summary>
    /// 分页查询字典值
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysDictData/page")]
    public async Task<dynamic> QueryDictDataPageList([FromQuery] DictDataInput input)
    {
        var code = !string.IsNullOrEmpty(input.Code?.Trim());
        var value = !string.IsNullOrEmpty(input.Value?.Trim());
        var dictDatas = await _sysDictDataRep
            .Where(u => u.TypeId == input.TypeId)
            .WhereIF(!string.IsNullOrWhiteSpace(input.Code), u => u.Code.Contains(input.Code.Trim()))
            .WhereIF(!string.IsNullOrWhiteSpace(input.Value), u => u.Value.Contains(input.Value.Trim()))
            .Where(u => u.Status != CommonStatus.DELETED).OrderBy(u => u.Sort)
            .Select<DictDataOutput>()
            .ToPagedListAsync(input.PageNo, input.PageSize);
        return dictDatas.XnPagedResult();
    }

    /// <summary>
    /// 获取某个字典类型下字典值列表
    /// </summary>
    /// <returns></returns>
    [HttpGet("/sysDictData/list")]
    public async Task<dynamic> GetDictDataList([FromQuery] QueryDictDataListInput input)
    {
        return await _sysDictDataRep.AsQueryable()
           .WhereIF(input.TypeId > 0, u => u.TypeId == input.TypeId)
           .Where(u => u.Status != CommonStatus.DELETED).OrderBy(u => u.Sort).ToListAsync();
    }

    /// <summary>
    /// 增加字典值
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictData/add")]
    public async Task AddDictData(AddDictDataInput input)
    {
        var isExist = await _sysDictDataRep.AnyAsync(u => (u.Code == input.Code || u.Value == input.Value) && u.TypeId == input.TypeId);
        if (isExist) throw Oops.Oh(ErrorCode.D3003);

        var dictData = input.Adapt<SysDictData>();
        await _sysDictDataRep.InsertAsync(dictData);
    }

    /// <summary>
    /// 删除字典值
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictData/delete")]
    public async Task DeleteDictData(DeleteDictDataInput input)
    {
        var dictData = await _sysDictDataRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (dictData == null) throw Oops.Oh(ErrorCode.D3004);

        await _sysDictDataRep.DeleteAsync(dictData);
    }

    /// <summary>
    /// 更新字典值
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictData/edit")]
    public async Task UpdateDictData(UpdateDictDataInput input)
    {
        var isExist = await _sysDictDataRep.AnyAsync(u => u.Id == input.Id);
        if (!isExist) throw Oops.Oh(ErrorCode.D3004);

        // 排除自己并且判断与其他是否相同
        isExist = await _sysDictDataRep.AnyAsync(u => (u.Value == input.Value || u.Code == input.Code) && u.TypeId == input.TypeId && u.Id != input.Id);
        if (isExist) throw Oops.Oh(ErrorCode.D3003);

        var dictData = input.Adapt<SysDictData>();
        await _sysDictDataRep.AsUpdateable(dictData).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
    }

    /// <summary>
    /// 字典值详情
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/sysDictData/detail")]
    public async Task<dynamic> GetDictData([FromQuery] QueryDictDataInput input)
    {
        return await _sysDictDataRep.FirstOrDefaultAsync(u => u.Id == input.Id);
    }

    /// <summary>
    /// 修改字典值状态
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/sysDictData/changeStatus")]
    public async Task ChangeDictDataStatus(UpdateDictDataInput input)
    {
        var dictData = await _sysDictDataRep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (dictData == null) throw Oops.Oh(ErrorCode.D3004);

        if (!Enum.IsDefined(typeof(CommonStatus), input.Status))
            throw Oops.Oh(ErrorCode.D3005);
        dictData.Status = input.Status;
    }

    /// <summary>
    /// 根据字典类型Id获取字典值集合
    /// </summary>
    /// <param name="dictTypeId"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<dynamic> GetDictDataListByDictTypeId(long dictTypeId)
    {
        return await _sysDictDataRep.Where(u => u.TypeId == dictTypeId)
                                                    .Where(u => u.Status != CommonStatus.DELETED).OrderBy(u => u.Sort)
                                                    .Select(u => new
                                                    {
                                                        u.Code,
                                                        u.Value
                                                    }).ToListAsync();
    }

    /// <summary>
    /// 删除字典下所有值
    /// </summary>
    /// <param name="dictTypeId"></param>
    [NonAction]
    public async Task DeleteByTypeId(long dictTypeId)
    {
        await _sysDictDataRep.DeleteAsync(u => u.TypeId == dictTypeId);
    }


    /// <summary>
    /// 根据字典Code返回字典值列表
    /// </summary>
    /// <param name="code"></param>
    /// <returns></returns>
    [NonAction]
    public async Task<List<SysDictData>> GetDictDataByCode(string code)
    {
        var payment = await _sysDictDataRep.AsQueryable().InnerJoin<SysDictType>((d, t) => d.TypeId == t.Id).Where((d, t) => t.Code == code).Select<SysDictData>().ToListAsync();
        return payment;
    }
}
