using System;
using System.Threading;
using System.Reflection;
using System.Threading.Tasks;

using Microsoft.Extensions.Options;
using Microsoft.Extensions.Configuration;

using DbUp;
using DbUp.Engine;
using DbUp.Support;

namespace CA.MigratorDB
{
  public class App
  {
    private readonly ConnectionStringCollection _settings;

    public App(IOptions<ConnectionStringCollection> settings) { _settings = settings.Value; }

    public async Task RunAsync(string[] args)
    {
      try
      {
        /* Inicio de la tarea asíncrona. */
        await Task.Run(() => {
          /* Cadena de conexión a la Base de Datos tomada desde el archivo AppConfig.json. */
          var connectionString = _settings.ConnectionStringSQLServer;

          /* Creamos la Base de Datos, si no existe... */
          EnsureDatabase.For.SqlDatabase(connectionString);

          /* Configuramos el motor de migración de Base de Datos de DbUp. */
          var upgradeEngineBuilder = DeployChanges.To.SqlDatabase(connectionString, null)
                                                  // Pre-deployment scripts: configurarlos para que siempre se ejecuten en el primer grupo.
                                                  .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith($"CA.MigratorDB.SQLScripts.BeforeDeployment."), new SqlScriptOptions { ScriptType = ScriptType.RunOnce, RunGroupOrder = 0 })
                                                  // Main Deployment scripts: se ejectan solo una vez y corren en el segundo grupo.
                                                  .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith($"CA.MigratorDB.SQLScripts.Deployment."), new SqlScriptOptions { ScriptType = ScriptType.RunOnce, RunGroupOrder = 1 })
                                                  // Post deployment scripts: siempre se ejecutan estos scripts después de que todo se haya implementado.
                                                  .WithScriptsEmbeddedInAssembly(Assembly.GetExecutingAssembly(), x => x.StartsWith($"CA.MigratorDB.SQLScripts.PostDeployment."), new SqlScriptOptions { ScriptType = ScriptType.RunAlways, RunGroupOrder = 2 })
                                                  // De forma predeterminada, todos los scripts se ejecutan en la misma transacción.
                                                  .WithTransactionPerScript()
                                                  // Colocar el log en la consola.
                                                  .LogToConsole();

          /* Construimos el proceso de migración. */
          Console.WriteLine($"Aplicando cambios en Base de Datos...");
          var upgrader = upgradeEngineBuilder.Build();

          if (upgrader.IsUpgradeRequired())
          {
            var result = upgrader.PerformUpgrade();

            /* Mostrar el resultado. */
            if (result.Successful)
            {
              Console.ForegroundColor = ConsoleColor.Green;
              Console.WriteLine($"Ejecución satisfactoria de la migración a Base de Datos.");
            }
            else
            {
              Console.ForegroundColor = ConsoleColor.Red;
              Console.WriteLine($"La migración de Base de Datos falló. No se aplicaron cambios. Revise el siguiente mensaje de error.");
              Console.WriteLine(result.Error);
            }

            Console.ResetColor();
          }

          Thread.Sleep(500);
        }).ConfigureAwait(false);
      }
      catch (Exception oEx)
      {
        Console.WriteLine($"Ocurrió un error al realizar este proceso de migración de Base de Datos: {oEx.Message.Trim()}.");
      }
      finally
      {
        Console.WriteLine($"Pulse cualquier tecla para salir..."); Console.ReadLine();
      }
    }
  }
}

