using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Magic.Core.Service;

public class EditTableInput
{
    public string Name { get; set; }

    public string OldName { get; set; }

    public string Description { get; set; }
}
