using System;

namespace CA.MigratorDB
{
  [Serializable]
  public class ConnectionStringCollection
  {
    public string ConnectionStringSQLServer { get; set; }
    public string ConnectionStringMySQLServer { get; set; }
  }
}
