using Furion;
using Furion.DependencyInjection;
using Furion.DynamicApiController;
using Furion.FriendlyException;
using Furion.ViewEngine;
using Magic.Core.Entity;
using Mapster;
using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

/// <summary>
/// 代码生成器服务
/// </summary>
[ApiDescriptionSettings(Name = "CodeGen", Order = 100)]
public class CodeGenService : ICodeGenService, IDynamicApiController, ITransient
{
    private readonly SqlSugarRepository<SysCodeGen> _sysCodeGenRep; // 代码生成器仓储
    private readonly ICodeGenConfigService _codeGenConfigService;
    private readonly IViewEngine _viewEngine;

    private readonly SqlSugarRepository<SysMenu> _sysMenuRep; // 菜单表仓储

    private readonly ICommonService _commonService;

    public CodeGenService(SqlSugarRepository<SysCodeGen> sysCodeGenRep,
                          ICodeGenConfigService codeGenConfigService,
                          IViewEngine viewEngine,
                          ICommonService commonService,
                          SqlSugarRepository<SysMenu> sysMenuRep)
    {
        _sysCodeGenRep = sysCodeGenRep;
        _codeGenConfigService = codeGenConfigService;
        _viewEngine = viewEngine;
        _sysMenuRep = sysMenuRep;
        _commonService = commonService;
    }

    /// <summary>
    /// 分页查询
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/codeGenerate/page")]
    public async Task<dynamic> QueryCodeGenPageList([FromQuery] CodeGenInput input)
    {
        var tableName = !string.IsNullOrEmpty(input.TableName?.Trim());
        var codeGens = await _sysCodeGenRep.AsQueryable()
            .WhereIF(!string.IsNullOrWhiteSpace(input.TableName), u => u.TableName.Contains(input.TableName.Trim()))
                                           .ToPagedListAsync(input.PageNo, input.PageSize);
        return codeGens.XnPagedResult();
    }

    /// <summary>
    /// 增加
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/codeGenerate/add")]
    public async Task AddCodeGen(AddCodeGenInput input)
    {
        var isExist = await _sysCodeGenRep.AnyAsync(u => u.TableName == input.TableName);
        if (isExist)
            throw Oops.Oh(ErrorCode.D1400);

        var codeGen = input.Adapt<SysCodeGen>();
        var newCodeGen = await _sysCodeGenRep.InsertReturnEntityAsync(codeGen);
        // 加入配置表中
        _codeGenConfigService.AddList(GetColumnList(input), newCodeGen);
    }

    /// <summary>
    /// 删除
    /// </summary>
    /// <param name="inputs"></param>
    /// <returns></returns>
    [HttpPost("/codeGenerate/delete")]
    public async Task DeleteCodeGen(List<DeleteCodeGenInput> inputs)
    {
        if (inputs == null || inputs.Count < 1) return;

        var codeGenConfigTaskList = new List<Task>();
        inputs.ForEach(u =>
        {
            _sysCodeGenRep.Delete(u.Id);

            // 删除配置表中
            codeGenConfigTaskList.Add(_codeGenConfigService.Delete(u.Id));
        });
        await Task.WhenAll(codeGenConfigTaskList);
    }

    /// <summary>
    /// 更新
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpPost("/codeGenerate/edit")]
    public async Task UpdateCodeGen(UpdateCodeGenInput input)
    {
        var isExist = await _sysCodeGenRep.AnyAsync(u => u.TableName == input.TableName && u.Id != input.Id);
        if (isExist)
            throw Oops.Oh(ErrorCode.D1400);

        var codeGen = input.Adapt<SysCodeGen>();
        await _sysCodeGenRep.UpdateAsync(codeGen);
    }

    /// <summary>
    /// 详情
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    [HttpGet("/codeGenerate/detail")]
    public async Task<SysCodeGen> GetCodeGen([FromQuery] QueryCodeGenInput input)
    {
        return await _sysCodeGenRep.SingleAsync(m => m.Id == input.Id);
    }

    /// <summary>
    /// 获取数据库表(实体)集合
    /// </summary>
    /// <returns></returns>
    [HttpGet("/codeGenerate/InformationList")]
    public async Task<List<TableOutput>> GetTableList()
    {
        IEnumerable<EntityInfo> entityInfos = await _commonService.GetEntityInfos(false);
        List<TableOutput> result = new List<TableOutput>();
        foreach (var item in entityInfos)
        {
            result.Add(new TableOutput()
            {
                EntityName = item.EntityName,
                TableName = item.DbTableName,
                TableComment = item.TableDescription
            });
        }
        return result;
    }

    /// <summary>
    /// 根据表名获取列
    /// </summary>
    /// <returns></returns>
    [HttpGet("/codeGenerate/ColumnList/{tableName}")]
    public List<TableColumnOuput> GetColumnListByTableName(string tableName)
    {
        // 获取实体类型属性
        var entityType = _sysCodeGenRep.Context.DbMaintenance.GetTableInfoList().FirstOrDefault(u => u.Name == tableName);
        if (entityType == null) return null;

        // 按原始类型的顺序获取所有实体类型属性（不包含导航属性，会返回null）
        return _sysCodeGenRep.Context.DbMaintenance.GetColumnInfosByTableName(entityType.Name).Select(u => new TableColumnOuput
        {
            ColumnName = u.DbColumnName,
            ColumnKey = u.IsPrimarykey.ToString(),
            DataType = u.DataType.ToString(),
            NetType = CodeGenUtil.ConvertDataType(u.DataType.ToString()),
            ColumnComment = u.ColumnDescription
        }).ToList();
    }

    /// <summary>
    /// 获取数据表列（实体属性）集合
    /// </summary>
    /// <returns></returns>
    [NonAction]
    public List<TableColumnOuput> GetColumnList([FromQuery] AddCodeGenInput input)
    {
        var entityType = _commonService.GetEntityInfos().Result.FirstOrDefault(m => m.EntityName == input.TableName);
        if (entityType == null)
            return null;

        return _sysCodeGenRep.Context.DbMaintenance.GetColumnInfosByTableName(entityType.DbTableName,false).Select(u => new TableColumnOuput
        {
            ColumnName = u.DbColumnName,
            ColumnKey = u.IsPrimarykey.ToString(),
            DataType = u.DataType.ToString(),
            ColumnComment = string.IsNullOrWhiteSpace(u.ColumnDescription) ? u.DbColumnName : u.ColumnDescription
        }).ToList();
    }

    /// <summary>
    /// 代码生成_本地项目
    /// </summary>
    /// <returns></returns>
    [HttpPost("/codeGenerate/runLocal")]
    public async Task RunLocal(SysCodeGen input)
    {
        // 先删除该表已生成的菜单列表
        var templatePathList = GetTemplatePathList();
        var targetPathList = GetTargetPathList(input);
        for (var i = 0; i < templatePathList.Count; i++)
        {
            var tContent = File.ReadAllText(templatePathList[i]);

            var tableFieldList = await _codeGenConfigService.List(new CodeGenConfig() { CodeGenId = input.Id }); // 字段集合
            if (i >= 5) // 适应前端首字母小写
            {
                tableFieldList.ForEach(u =>
                {
                    u.ColumnName = u.ColumnName.Substring(0, 1).ToLower() + u.ColumnName[1..];
                });
            }

            var queryWhetherList = tableFieldList.Where(u => u.QueryWhether == YesOrNot.Y.ToString()).ToList(); // 前端查询集合
            var tResult = _viewEngine.RunCompileFromCached(tContent, new
            {
                input.AuthorName,
                input.BusName,
                input.NameSpace,
                ClassName = input.TableName,
                QueryWhetherList = queryWhetherList,
                TableField = tableFieldList
            });

            var dirPath = new DirectoryInfo(targetPathList[i]).Parent.FullName;
            if (!Directory.Exists(dirPath))
                Directory.CreateDirectory(dirPath);
            File.WriteAllText(targetPathList[i], tResult, Encoding.UTF8);
        }

        await AddMenu(input.TableName, input.BusName, input.MenuApplication, input.MenuPid);
    }

    private async Task AddMenu(string className, string busName, string application, long pid)
    {
        // 定义菜单编码前缀
        var codePrefix = "magic_" + className.ToLower();

        // 先删除该表已生成的菜单列表
        await _sysMenuRep.DeleteAsync(u => u.Code.StartsWith(codePrefix));

        // 如果 pid 为 0 说明为顶级菜单, 需要创建顶级目录
        if (pid == 0)
        {
            // 目录
            var menuType0 = new SysMenu
            {
                Pid = 0,
                Pids = "[0],",
                Name = busName + "管理",
                Code = codePrefix,
                Type = 1,
                Icon = "robot",
                Router = "/" + className.ToLower(),
                Component = "PageView",
                Application = application
            };
            pid = (await _sysMenuRep.InsertReturnEntityAsync(menuType0)).Id;
        }
        // 由于后续菜单会有修改, 需要判断下 pid 是否存在, 不存在报错
        else if (!await _sysMenuRep.AnyAsync(e => e.Id == pid))
            throw Oops.Oh(ErrorCode.D1505);

        // 菜单
        var menuType1 = new SysMenu
        {
            Pid = pid,
            Pids = "[0],[" + pid + "],",
            Name = busName + "管理",
            Code = codePrefix + "_mgr",
            Type = 1,
            Router = "/" + className.ToLower(),
            Component = "main/" + className + "/index",
            Application = application,
            OpenType = 1
        };
        var pid1 = (await _sysMenuRep.InsertReturnEntityAsync(menuType1)).Id;



        // 按钮-page
        var menuType2 = new SysMenu
        {
            Pid = pid1,
            Pids = "[0],[" + pid + "],[" + pid1 + "],",
            Name = busName + "查询",
            Code = codePrefix + "_mgr_page",
            Type = 2,
            Permission = className + ":page",
            Application = application,
        };

        // 按钮-detail
        var menuType2_1 = new SysMenu
        {
            Pid = pid1,
            Pids = "[0],[" + pid + "],[" + pid1 + "],",
            Name = busName + "详情",
            Code = codePrefix + "_mgr_detail",
            Type = 2,
            Permission = className + ":detail",
            Application = application,
        };

        // 按钮-add
        var menuType2_2 = new SysMenu
        {
            Pid = pid1,
            Pids = "[0],[" + pid + "],[" + pid1 + "],",
            Name = busName + "增加",
            Code = codePrefix + "_mgr_add",
            Type = 2,
            Permission = className + ":add",
            Application = application,
        };

        // 按钮-delete
        var menuType2_3 = new SysMenu
        {
            Pid = pid1,
            Pids = "[0],[" + pid + "],[" + pid1 + "],",
            Name = busName + "删除",
            Code = codePrefix + "_mgr_delete",
            Type = 2,
            Permission = className + ":delete",
            Application = application,
        };

        // 按钮-edit
        var menuType2_4 = new SysMenu
        {
            Pid = pid1,
            Pids = "[0],[" + pid + "],[" + pid1 + "],",
            Name = busName + "编辑",
            Code = codePrefix + "_mgr_edit",
            Type = 2,
            Permission = className + ":edit",
            Application = application,
        };

        List<SysMenu> menuList = new List<SysMenu>() { menuType2, menuType2_1, menuType2_2, menuType2_3, menuType2_4 };
        await _sysMenuRep.InsertAsync(menuList);
    }

    /// <summary>
    /// 获取模板文件路径集合
    /// </summary>
    /// <returns></returns>
    private List<string> GetTemplatePathList()
    {
        var templatePath = Path.Combine(App.WebHostEnvironment.WebRootPath, "Template");
        return new List<string>()
        {
           Path.Combine(templatePath , "Service.cs.vm"),
            Path.Combine(templatePath , "IService.cs.vm"),
            Path.Combine(templatePath , "Input.cs.vm"),
            Path.Combine(templatePath , "Output.cs.vm"),
            Path.Combine(templatePath , "Dto.cs.vm"),
            Path.Combine(templatePath , "index.vue.vm"),
            Path.Combine(templatePath , "addForm.vue.vm"),
            Path.Combine(templatePath , "editForm.vue.vm"),
            Path.Combine(templatePath , "manage.js.vm"),
        };
    }

    /// <summary>
    /// 设置生成文件路径
    /// </summary>
    /// <param name="input"></param>
    /// <returns></returns>
    private List<string> GetTargetPathList(SysCodeGen input)
    {
        var backendPath = Path.Combine(new DirectoryInfo(App.WebHostEnvironment.ContentRootPath).Parent.FullName, "Magic.Application", "Service", input.TableName);
        var servicePath = Path.Combine(backendPath, input.TableName + "Service.cs");
        var iservicePath = Path.Combine(backendPath, "I" + input.TableName + "Service.cs");
        var inputPath = Path.Combine(backendPath, "Dto", input.TableName + "Input.cs");
        var outputPath = Path.Combine(backendPath, "Dto", input.TableName + "Output.cs");
        var viewPath = Path.Combine(backendPath, "Dto", input.TableName + "Dto.cs");
        var frontendPath = Path.Combine(new DirectoryInfo(App.WebHostEnvironment.ContentRootPath).Parent.Parent.FullName, "frontend", "src", "views", "main");
        var indexPath = Path.Combine(frontendPath, input.TableName, "index.vue");
        var addFormPath = Path.Combine(frontendPath, input.TableName, "addForm.vue");
        var editFormPath = Path.Combine(frontendPath, input.TableName, "editForm.vue");
        var apiJsPath = Path.Combine(new DirectoryInfo(App.WebHostEnvironment.ContentRootPath).Parent.Parent.FullName, "frontend", "src", "api", "modular", "main", input.TableName + "Manage.js");

        return new List<string>()
        {
            servicePath,
            iservicePath,
            inputPath,
            outputPath,
            viewPath,
            indexPath,
            addFormPath,
            editFormPath,
            apiJsPath
        };
    }
}
