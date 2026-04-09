var builder = WebApplication.CreateBuilder(args);

builder.WebHost.UseUrls("http://0.0.0.0:80");
  
var app = builder.Build();

app.MapGet("/", () => "Blue-Green Deployment Demo Working");

app.Run();
