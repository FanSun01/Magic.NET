// See https://aka.ms/new-console-template for more information




using Magic.CodeFirst;
using Magic.Core;
using Magic.Core.Entity;
using Microsoft.Extensions.Configuration;
using SqlSugar;
using System.Collections;
using System.Data;
using System.Reflection;
using System.Text;




var assembles = new string[] { "Magic.FlowCenter.dll", "Magic.Core.dll" };
//首先创建数据库
CreateDatabase();
//初始化表结构
InitDatabase(assembles);
//插入种子数据
InsertData();
Console.WriteLine("数据库迁移成功");
Console.ReadLine();


static void CreateDatabase() {
    var conn = SqlSugarHelper.GetSetting();
    SqlSugarHelper.Db().GetConnectionScope(conn.DefaultDbNumber).DbMaintenance.CreateDatabase();
    foreach (var item in conn.DbConfigs)
    {
        if (item.DbType != SqlSugar.DbType.Oracle.ToString())
            SqlSugarHelper.Db().GetConnectionScope(item.DbNumber).DbMaintenance.CreateDatabase();
    }
}


static void InitDatabase(string[] assembles) {
    var conn = SqlSugarHelper.GetSetting();
    var configIds = new List<string>();
    configIds.Add(conn.DefaultDbNumber);
    foreach (var item in conn.DbConfigs)
    {
        configIds.Add(item.DbNumber);
    }

    foreach (var item in assembles)
    {
        Type[] types = Assembly
           .LoadFrom(item)//如果 .dll报错，可以换成 xxx.exe 有些生成的是exe 
           .GetTypes()
           .Where(m => m.GetCustomAttribute<SugarTable>() != null && m.Name != "FlcFlowinstanceOutput")
           .ToArray();

        foreach (Type type in types) {
            if (type.GetCustomAttribute<TenantAttribute>() == null)
            {
                SqlSugarHelper.Db().CodeFirst.InitTables(type);
            }
            else {
                SqlSugarHelper.Db().GetConnectionScope(type.GetCustomAttribute<TenantAttribute>().configId).CodeFirst.InitTables(type);
            }
        }

        //SqlSugarHelper.Db().CodeFirst.InitTables(types);

        Console.WriteLine($"数据库{item}创建成功");
    }


   
}


static void CreateSeedData(string[] assembles)
{
    foreach (var item in assembles)
    {
        Type[] types = Assembly
           .LoadFrom(item)//如果 .dll报错，可以换成 xxx.exe 有些生成的是exe 
           .GetTypes()
           .Where(m => m.GetCustomAttribute<SugarTable>() != null && m.Name != "FlcFlowinstanceOutput")
           .ToArray();

        //Get type of Worker
        SelectTable worker = new SelectTable();

        //Get type of Worker
        Type workerType = typeof(SelectTable);

        //Get Generic Method
        MethodInfo staticDoWorkMethod = workerType.GetMethod("GetAll");

        //Invoke StaticDoWork<T>
        foreach (Type curType in types)
        {
            if (curType.IsClass && !curType.IsAbstract)
            {
                MethodInfo curMethod = staticDoWorkMethod.MakeGenericMethod(curType);
                var list = curMethod.Invoke(null, null);
                if (list == null) continue;
                var path = Path.Combine(@"D:\Workspace\admin-net-sqlsugar\backend\Magic.CodeFirst\SeedData", $"{curType.Name}SeedData.cs");


                if (File.Exists(path))
                    File.Delete(path);

                FileStream fs = new FileStream(path, FileMode.CreateNew, FileAccess.ReadWrite);
                StreamWriter sw = new StreamWriter(fs);
                StringBuilder sb = new StringBuilder($@"using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class {curType.Name}SeedData : ISeedData , ISqlSugarEntitySeedData<{curType.Name}>
{{  public IEnumerable<{curType.Name}> HasData()
    {{  string json = @""");
                sb.AppendLine(JsonUtil.ToJsonString(list).Replace(@"""", @""""""));
                sb.AppendLine(@""";");

                sb.AppendLine($@" List<{curType.Name}> list = JsonUtil.ToObject<List<{curType.Name}>>(json);

        return list;");
                sb.AppendLine(@"}}");
                sw.Write(sb.ToString());
                sw.Flush();
                sw.Close();

            };
        }
    }
   

}





static void InsertData()
{
    var baseType = typeof(ISeedData);
    var path = AppDomain.CurrentDomain.RelativeSearchPath ?? AppDomain.CurrentDomain.BaseDirectory;
    var referencedAssemblies = System.IO.Directory.GetFiles(path, "Magic.CodeFirst.dll").Select(Assembly.LoadFrom).ToArray();
    var seedDataTypes = referencedAssemblies
        .SelectMany(a => a.DefinedTypes)
        .Select(type => type.AsType())
        .Where(x => x != baseType && baseType.IsAssignableFrom(x)).ToArray();

    foreach (var seedType in seedDataTypes)
    {
        var instance = Activator.CreateInstance(seedType);

        var hasDataMethod = seedType.GetMethod("HasData");
        var seedData = ((IEnumerable)hasDataMethod?.Invoke(instance, null))?.Cast<object>();
        if (seedData == null) continue;

        var entityType = seedType.GetInterfaces().First().GetGenericArguments().First();

        var seedDataTable = seedData.ToList().ToDataTable();
        seedDataTable.TableName = SqlSugarHelper.Db().EntityMaintenance.GetEntityInfo(entityType).DbTableName;

        var storage = SqlSugarHelper.Db().Storageable(seedDataTable).ToStorage();
        storage.AsInsertable.ExecuteCommand();
    }
}


public static class ObjectExtension
{
    public static DataTable ToDataTable<T>(this List<T> list)
    {
        DataTable result = new();
        if (list.Count > 0)
        {
            // result.TableName = list[0].GetType().Name; // 表名赋值
            PropertyInfo[] propertys = list[0].GetType().GetProperties();
            foreach (PropertyInfo pi in propertys)
            {
                Type colType = pi.PropertyType;
                if (colType.IsGenericType && colType.GetGenericTypeDefinition() == typeof(Nullable<>))
                {
                    colType = colType.GetGenericArguments()[0];
                }
                if (IsIgnoreColumn(pi))
                    continue;
                result.Columns.Add(pi.Name, colType);
            }
            for (int i = 0; i < list.Count; i++)
            {
                ArrayList tempList = new();
                foreach (PropertyInfo pi in propertys)
                {
                    if (IsIgnoreColumn(pi))
                        continue;
                    object obj = pi.GetValue(list[i], null);
                    tempList.Add(obj);
                }
                object[] array = tempList.ToArray();
                result.LoadDataRow(array, true);
            }
        }
        return result;
    }

    private static bool IsIgnoreColumn(PropertyInfo pi)
    {
        var sc = pi.GetCustomAttributes<SugarColumn>(false).FirstOrDefault(u => u.IsIgnore == true);
        return sc != null;
    }
}

public class SelectTable
{
    public static List<T> GetAll<T>()
    {
        var list = SqlSugarHelper.Db().Queryable<T>().ToList();
        return list.Any() ? list : null;
    }
}