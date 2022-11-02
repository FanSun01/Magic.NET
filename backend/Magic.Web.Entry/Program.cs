
using Magic.Core;

Serve.Run(RunOptions.Default.ConfigureBuilder(builder => { 
    builder.UseLoggingFile();
}));

