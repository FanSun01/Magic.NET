using Magic.Core;
using Magic.Core.Entity;

namespace Magic.CodeFirst;

public class SysEmpPosSeedData : ISeedData , ISqlSugarEntitySeedData<SysEmpPos>
{  public IEnumerable<SysEmpPos> HasData()
    {  string json = @"[{""SysEmpId"":177325484421189,""SysPosId"":177325394366533},{""SysEmpId"":182314279026757,""SysPosId"":177325394366533}]
";
 List<SysEmpPos> list = JsonUtil.ToObject<List<SysEmpPos>>(json);

        return list;
}}
