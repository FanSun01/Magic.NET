using Mapster;
using SqlSugar;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service.DataBase.Extension
{
    internal static class DbMaintenanceExtension
    {
        public static bool IsAnyTableRemarkEx(this IDbMaintenance dbMaintenance, string tableName)
        {
            return dbMaintenance.Context.CurrentConnectionConfig.DbType switch
            {
                DbType.MySql => new Func<bool>(() =>
                {
                    string sql = $"select 1 from information_schema.`Tables` where table_name=@tableName";
                    return dbMaintenance.Context.Ado.GetDataTable(sql, new SugarParameter("@tableName", tableName)).Rows?.Count > 0;
                })(),
                _ => dbMaintenance.IsAnyTableRemark(tableName)
            };
        }

        public static bool IsAnyColumnRemarkEx(this IDbMaintenance dbMaintenance, string tableName, string columnName)
        {
            return dbMaintenance.Context.CurrentConnectionConfig.DbType switch
            {
                DbType.MySql => new Func<bool>(() =>
                {
                    string sql = $"select 1 from information_schema.`Columns` where table_name=@tableName and column_name=@columnName";
                    return dbMaintenance.Context.Ado.GetDataTable(sql, new SugarParameter("@tableName", tableName), new SugarParameter("@columnName", columnName)).Rows?.Count > 0;
                })(),
                _ => dbMaintenance.IsAnyColumnRemark(columnName, tableName)
            };
        }

        public static void AddColumnRemarkEx(this IDbMaintenance dbMaintenance, string columnName, string tableName, string columnDescription)
        {
            switch (dbMaintenance.Context.CurrentConnectionConfig.DbType)
            {
                case DbType.MySql:
                    var colInfo = dbMaintenance.GetColumnInfosByTableName(tableName, false)
                        .Adapt<List<DbColumnInfoOutput>>()
                        .Where(x => string.Compare(x.DbColumnName, columnName, true) == 0)
                        .FirstOrDefault();

                    dbMaintenance.UpdateColumn(tableName, new DbColumnInfo()
                    {
                        ColumnDescription = columnDescription,
                        DataType = $"{colInfo.DataType}{GetSize(colInfo.Length, colInfo.DecimalDigits)} COMMENT '{columnDescription.Replace("\'", "\\\'").Replace("\"", "\\\"")}' ",
                        DbColumnName = colInfo.DbColumnName,
                        DefaultValue = colInfo.DefaultValue,
                        IsArray = colInfo.IsArray,
                        IsIdentity = colInfo.IsIdentity,
                        IsNullable = colInfo.IsNullable,
                        IsPrimarykey = colInfo.IsPrimarykey,
                        PropertyName = colInfo.PropertyName,
                        Scale = colInfo.Scale,
                        TableId = colInfo.TableId,
                        TableName = colInfo.TableName,
                        Value = colInfo.Value
                    });
                    break;

                default:
                    dbMaintenance.AddColumnRemark(columnName, tableName, string.IsNullOrWhiteSpace(columnDescription) ? columnName : columnDescription);
                    break;
            }
        }

        private static string GetSize(int size = 0, int decimalDigits = 0)
        {
            string dataSize = null;
            var isMax = size > 4000 || size == -1;
            if (isMax)
            {
                dataSize = size > 0 ? string.Format("({0})", "max") : null;
            }
            else if (size == 0 && decimalDigits > 0)
            {
                size = 10;
                dataSize = string.Format("({0},{1})", size, decimalDigits);
            }
            else if (size > 0 && decimalDigits == 0)
            {
                dataSize = size > 0 ? string.Format("({0})", size) : null;
            }
            else if (size > 0 && decimalDigits > 0)
            {
                dataSize = size > 0 ? string.Format("({0},{1})", size, decimalDigits) : null;
            }
            return dataSize;
        }
    }
}