using Furion;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Extensions.Logging;
using Microsoft.Extensions.Options;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using Yitter.IdGenerator;


namespace Magic.Core.Service;

/// <summary>
/// 文档服务
/// </summary>
[ApiDescriptionSettings(Name = "Document", Order = 150)]
public class DocumentService : IDocumentService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<Documentation> _rep;
    private readonly ISysDictDataService _sysDictDataService;
    private readonly UploadFileOptions _options;
    private readonly ILogger<DocumentService> _logger;
    public DocumentService(ILogger<DocumentService> logger, SqlSugarRepository<Documentation> rep, IOptions<UploadFileOptions> options, ISysDictDataService sysDictDataService)
    {
        this._logger = logger;
        _rep = rep;
        this._sysDictDataService = sysDictDataService;
        this._options = options.Value;
    }
    #region API
    /// <summary>
    /// 分页查询文档
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/Document/page")]
    public async Task<dynamic> Page([FromQuery] DocumentInput input)
    {
        //获取字典
        var fileTypes = await _sysDictDataService.GetDictDataByCode("file_type");
        List<string> fileTypeList = null;
        #region 判断是否根据类型搜索
        if (!string.IsNullOrEmpty(input.FileType))
        {
            if (input.FileType == "文件夹")
            {
                input.DocumentType = DocumentType.Folder;
            }
            else
            {
                var data = fileTypes.Where(it => it.Value == input.FileType).FirstOrDefault();
                if (data != null)
                {
                    fileTypeList = new List<string>();
                    data.Code.Split(",").ToList().ForEach(it =>
                    {
                        fileTypeList.Add($".{it}");
                    });

                }
            }

        }
        #endregion
        var entities = await _rep.AsQueryable()
                                 .WhereIF(!string.IsNullOrWhiteSpace(input.Name), u => u.Name.Contains(input.Name.Trim()))
                                 .WhereIF(fileTypeList != null, u => fileTypeList.Contains(u.FileSuffix))
                                 .WhereIF(input.Label != null, u => u.Label == input.Label)
                                 .WhereIF(input.DocumentType != null, u => u.DocumentType == input.DocumentType)
                                 .WhereIF(input.CreateTimeStart != null && input.CreateTimeEnd != null, u => SqlFunc.Between(u.CreatedTime, input.CreateTimeStart, input.CreateTimeEnd))
                                 .WhereIF(input.UpdateTimeStart != null && input.UpdateTimeEnd != null, u => SqlFunc.Between(u.UpdatedTime, input.UpdateTimeStart, input.UpdateTimeEnd))
                                 .WhereIF(input.PId != null, u => u.PId == input.PId)
                                 .Where(u => u.IsDeleted == input.IsDelete && u.Visible == true)
                                 .Filter(null, true)
                                 .OrderBy(u => u.DocumentType)
                                 .Select<DocumentOutput>()
                                 .Mapper(async it =>
                                 {
                                     if (it.FileSizeKb != null)
                                     {
                                         it.FileSize = GetUnit(it.FileSizeKb.Value);//文件大小转成字符串
                                     }

                                 })
                                 .ToPagedListAsync(input.PageNo, input.PageSize);

        #region 获取文件类型

        //遍历获取到的数据
        foreach (var it in entities.Items)
        {
            if (string.IsNullOrWhiteSpace(it.FileSuffix))
            {
                it.FileType = "文件夹";
            }
            else
            {
                //获取后缀名
                var fileSuffix = it.FileSuffix.Split(".")[1];
                foreach (var filetype in fileTypes)
                {
                    var types = filetype.Code.Split(',').ToArray();//获取所有后缀名
                    if (types.Contains(fileSuffix))//是否存在
                    {
                        it.FileType = filetype.Value;
                        break;
                    }
                }
                if (string.IsNullOrEmpty(it.FileType))
                {
                    it.FileType = "文件";
                }

            }

        }
        #endregion

        return entities.XnPagedResult();
    }


    /// <summary>
    /// 文件夹树
    /// </summary>
    /// <returns></returns>
    [HttpGet("/Document/tree")]
    public async Task<dynamic> Tree()
    {

        var tree = await _rep
            .Where(it => it.DocumentType == DocumentType.Folder)
            .ToTreeAsync(it => it.Children, it => it.PId, 0);
        var result = tree.Adapt<List<DocumentTreeOutPut>>();
        return result;
    }

    /// <summary>
    /// 上传文件
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/upload")]
    public async Task Upload([FromForm] DocumentUploadInput input)
    {
        var fileNames = input.Files.Select(it => it.FileName).ToList();//获取文件列表名称
        var exist = await _rep.Where(it => fileNames.Contains(it.Name) && it.PId == input.PId).Select(it => it.Name).ToListAsync();//获取数据库中同名文件
        if (exist.Count > 0)
        {
            throw Oops.Oh($"同级目录下已存在相同文件名称{string.Join(",", exist)}");
        }
        else
        {
            foreach (var file in input.Files)
            {
                await UploadFile(file, input.PId.Value);
            }

        }

    }

    /// <summary>
    /// 上传文件夹
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/uploadfolder")]
    public async Task UploadFolder([FromForm] DocumentUploadInput input)
    {
        var pid = input.PId.Value;
        long firtId = 0;//主文件夹的ID
        Dictionary<string, List<string>> fileDic = new Dictionary<string, List<string>>();
        input.Files.ForEach(it =>
        {
            fileDic.Add(it.FileName, it.FileName.Split('/').ToList());//将文件名和分割的数组加到字典

        });

        //循环从0开始，小于字典中value最多的数量-1，因为后面要加2去拿
        for (int i = 0; i < fileDic.OrderByDescending(it => it.Value.Count).First().Value.Count - 1; i++)
        {
            //重新获取新的字典
            var files = fileDic.Where(it => it.Value.Count == i + 2).ToDictionary(it => it.Key, it => it.Value);
            if (firtId != 0) pid = firtId;//如果主文件夹id不为0表示创建过第一层的文件夹，后面的文件夹在第一层文件夹下面创建
            //循环创建文件夹
            var folders = files.ElementAt(0).Value;

            folders.RemoveAt(folders.Count - 1);//删掉最后一个文件夹名字
            bool isFirst = folders.Count == 1 ? true : false;//只有一个表示顶层文件夹
            if (folders.Count > 1)
            {
                folders.RemoveAt(0);//删掉第一层
            }
            foreach (var folder in folders)
            {
                Console.WriteLine($"新建文件夹:{folder}");
                pid = await Add(new AddDocumentInput { PId = pid, Name = folder });//创建文件夹
            }
            if (isFirst)//表示顶层
            {
                firtId = pid;
            }
            foreach (var dic in files)
            {
                var info = fileDic.Where(it => it.Key == dic.Key).First();//文件信息
                //var filename = dic.Value[i + 1];
                var file = input.Files.Where(it => it.FileName == info.Key).First();
                await UploadFile(file, pid);
            }
        }
    }


    /// <summary>
    /// 新建文件夹
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/add")]
    public async Task<long> Add(AddDocumentInput input)
    {
        var entity = input.Adapt<Documentation>();
        entity.DocumentType = DocumentType.Folder;
        var exist = await _rep.AnyAsync(it => it.Name == input.Name && it.PId == input.PId);
        if (exist) { throw Oops.Oh("ErrorMessage.E2000"); }
        var result = await _rep.AsInsertable(entity).IgnoreColumns(true).ExecuteReturnEntityAsync();
        return result.Id;
    }

    /// <summary>
    /// 删除文档
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/delete")]
    public async Task Delete(DeleteDocumentInput input)
    {
        var entity = await _rep.FirstOrDefaultAsync(it => it.Id == input.Id);
        if (entity != null)
        {
            entity.IsDeleted = true;
            await _rep.UpdateAsync(entity);
        }
        else
        {
            throw Oops.Oh("ErrorMessage.E404");

        }
    }


    /// <summary>
    /// 批量删除
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/deletes")]
    public async Task Deletes(DeletesDocumentInput input)
    {
        #region 所有isdelete=true
        var documents = await _rep.ToListAsync(it => input.Ids.Contains(it.Id));
        #endregion
        documents.ForEach(document => document.IsDeleted = true);
        await _rep.AsUpdateable(documents).UpdateColumns(it => new { it.IsDeleted, it.UpdatedTime, it.UpdatedUserId, it.UpdatedUserName }).ExecuteCommandAsync();
    }

    /// <summary>
    /// 移动文档
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/move")]
    public async Task Move(MoveDocumentInput input)
    {

        var tree = await GetParentList(input.PId.Value);//获取上级
        var ids = tree.Select(it => it.Id).ToList();//获取id列表
        if (ids.Count > 0)//去掉自己
        {
            ids.Remove(input.PId.Value);
        }
        var same = ids.Intersect(input.Ids).ToArray();//检查目标ID的父ID是否有选中的文件
        if (ids.Contains(input.PId.Value) || same.Length > 0)//判断父ID是否在列表
        {
            throw Oops.Oh("ErrorMessage.E2001");
        }

        //判断有没有相同名称的文件或者文件夹
        var names = await _rep.Where(it => input.Ids.Contains(it.Id)).Select(it => it.Name).ToListAsync();//文档列表
        var existName = await _rep.Where(it => it.PId == input.PId && names.Contains(it.Name)).AnyAsync();//文档列表
        if (existName)
        {
            throw Oops.Oh("ErrorMessage.E2002");
        }
        var pFolder = _rep.FirstOrDefault(it => it.Id == input.PId.Value);//获取父文件夹
        _rep.CurrentBeginTran();
        try
        {
			await _rep.UpdateAsync(it => input.Ids.Contains(it.Id), it => new Documentation { PId = input.PId.Value });
			if (pFolder != null)
			{
				await _rep.AsUpdateable(pFolder).UpdateColumns(it => new { it.UpdatedTime, it.UpdatedUserId, it.UpdatedUserName }).ExecuteCommandAsync();
			}
			_rep.CurrentCommitTran();
		}
        catch (Exception ex)
        {
            _rep.CurrentRollbackTran();
            _logger.LogError(ex, $"移动失败:{ex.Message}");
            throw Oops.Oh("ErrorMessage.E500");
        }
    }


    /// <summary>
    /// 更新文件夹
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/Document/edit")]
    public async Task Update(UpdateDocumentInput input)
    {
        var exist = await _rep.FirstOrDefaultAsync(it => it.Id == input.Id);
        if (exist != null)
        {
            if (!string.IsNullOrEmpty(exist.FileSuffix))//如果有后缀名加上后缀名
            {
                input.Name += $".{exist.FileSuffix}";
            }
            exist.Name = input.Name;
            exist.Remark = input.Remark;
            exist.Label = input.Label;
            //获取上级
            var tree = await GetParentList(exist.Id);
			_rep.CurrentBeginTran();
			try
			{
				if (tree.Count > 0)
				{
					//更新上级的修改时间
					await _rep.AsUpdateable(tree).UpdateColumns(it => new { it.UpdatedTime, it.UpdatedUserId, it.UpdatedUserName }).ExecuteCommandAsync();
				}
				await _rep.AsUpdateable(exist).IgnoreColumns(ignoreAllNullColumns: true).ExecuteCommandAsync();
				_rep.CurrentCommitTran();
			}
			catch (Exception ex)
			{
				_rep.CurrentRollbackTran();
				_logger.LogError(ex, $"更新文件夹失败:{ex.Message}");
				throw Oops.Oh("ErrorMessage.E500");
			}
		}
        else
        {
            throw Oops.Oh(ErrorCode.D1002);
        }

    }




    /// <summary>
    /// 获取文档
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/Document/detail")]
    public async Task<Documentation> Get([FromQuery] QueryeDocumentInput input)
    {
        var file = await _rep.FirstOrDefaultAsync(u => u.Id == input.Id);
        if (file == null)
            throw Oops.Oh(ErrorCode.D1002);
        return file;
    }


    /// <summary>
    /// 下载文件
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>

    [HttpGet("/Document/download")]
    public async Task<IActionResult> Download([FromQuery] QueryeDocumentInput input)
    {
        var file = await Get(input);
        var filePath = Path.Combine(App.WebHostEnvironment.WebRootPath, file.FilePath, file.FileObjectName);
        var fileName = HttpUtility.UrlEncode(file.Name, Encoding.GetEncoding("UTF-8"));
        var result = new FileStreamResult(new FileStream(filePath, FileMode.Open), "application/octet-stream") { FileDownloadName = fileName };
        return result;
    }

    /// <summary>
    /// 预览文件
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/Document/preview")]
    public async Task<string> Preview([FromQuery] QueryeDocumentInput input)
    {
        var file = await Get(input);
        return $"{file.FilePath}/{file.FileObjectName}";
    }


    #endregion

    #region 方法

    /// <summary>
    /// 创建Pids格式 
    /// 如果pid是0顶级节点，pids就是 [0];
    /// 如果pid不是顶级节点，pids就是 pid文档的 pids + [pid] + ,
    /// </summary>
    /// <param name="pid"></param>
    /// <returns></returns>
    private async Task<string> CreateNewPids(long pid)
    {
        if (pid == 0L)
        {
            return "0,";
        }
        else
        {
            var pmenu = await _rep.FirstOrDefaultAsync(u => u.Id == pid);
            return pmenu.PIds + $"{pid},";
        }
    }

    /// <summary>
    /// 获取文件大小
    /// </summary>
    /// <param name="fileSizeKb"></param>
    /// <returns></returns>
    [NonAction]
    private string GetUnit(int fileSizeKb)
    {

        var b = fileSizeKb * 1024;
        const int MB = 1024 * 1024;
        const int KB = 1024;
        if (b / MB >= 1)
        {
            return Math.Round(b / (float)MB, 2) + "MB";
        }

        if (b / KB >= 1)
        {
            return Math.Round(b / (float)KB, 2) + "KB";
        }
        if (b == 0)
        {
            return "0B";
        }
        return null;
    }

    /// <summary>
    /// 上传文件
    /// </summary>
    /// <param name="file"></param>
    /// <param name="pid"></param>
    /// <returns></returns>
    [NonAction]
    private async Task UploadFile(IFormFile file, long pid)
    {
        var now = DateTime.Now.ToString("d");
        var localPath = $"{_options.Document.path}/{now}";
        var filePath = Path.Combine(App.WebHostEnvironment.WebRootPath, localPath);
        if (!Directory.Exists(filePath))
            Directory.CreateDirectory(filePath);

        var fileSizeKb = (int)(file.Length / 1024.0); // 文件大小KB
        var originalFilename = Path.GetFileName(file.FileName); // 文件原始名称
        var fileSuffix = Path.GetExtension(file.FileName).ToLower(); // 文件后缀  
        var objectName = $"{ YitIdHelper.NextId()}{fileSuffix}";//存储文件名
        Documentation document = new Documentation
        {
            PId = pid,
            Name = originalFilename,
            FileSuffix = fileSuffix,
            FileSizeKb = fileSizeKb,
            DocumentType = DocumentType.File,
            FileObjectName = objectName,
            FilePath = localPath,
        };
        var result = await _rep.InsertAsync(document);//添加到数据库
        if (result > 0)
        {
            try
            {
                //上传文件
                using (var stream = File.Create(Path.Combine(filePath, objectName)))
                {
                    await file.CopyToAsync(stream);
                }
            }
            catch (Exception ex)
            {
                throw Oops.Oh($"保存文件{originalFilename}失败，请重新上传");
            }

        }
    }

    /// <summary>
    /// 获取父级
    /// </summary>
    /// <param name="id"></param>
    /// <returns></returns>
    private async Task<List<Documentation>> GetParentList(long id)
    {
        return await _rep.Where(it => it.DocumentType == DocumentType.Folder).ToParentListAsync(it => it.PId, id);
    }
    #endregion
}
