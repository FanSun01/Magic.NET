using Microsoft.AspNetCore.Mvc;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public interface IDataBaseManager
{
    List<DbTableInfo> GetTableInfoList();

    List<DbColumnInfoOutput> GetColumnInfosByTableName(string tableName);

    void TableAdd(DbTableInfoInput input);
    void TableEdit(EditTableInput input);
    void TableDelete(DbTableInfo input);

    void ColumnAdd(DbColumnInfoInput input);
    void ColumnEdit(EditColumnInput input);
    void ColumnDelete(DbColumnInfoOutput input);

    void CreateEntity(CreateEntityInput input);
}
