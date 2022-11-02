using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public class EditColumnInput
{
    public string TableName { get; set; }
    public string OldName { get; set; }
    public string DbColumnName { get; set; }
    public string ColumnDescription { get; set; }
}
