using OpenTelemetry.Metrics;
using OpenTelemetry.Resources;
using OpenTelemetry.Trace;
using OpenTelemetry;
using OpenTelemetry.Exporter;
using OpenTelemetry.Exporter.Prometheus;
using OpenTelemetry.Instrumentation.Runtime;
using MySqlConnector;

var builder = WebApplication.CreateBuilder(args);

builder.Services.AddControllers();
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
// Setup HTTP Client
builder.Services.AddHttpClient();

builder.Services.AddOpenTelemetry()
	.WithMetrics(x =>
    {
        x.AddPrometheusExporter();
        x.AddAspNetCoreInstrumentation();
        x.AddRuntimeInstrumentation();
        x.AddHttpClientInstrumentation();
        x.AddMeter(
                "Microsoft.AspNetCore.Hosting",
                "Microsoft.AspNetCore.Server.Kestrel");
        x.AddView("request - duration",
             new ExplicitBucketHistogramConfiguration
             {
                 Boundaries = new double[] { 0, 0.005, 0.01, 0.025, 0.05, 0.075, 0.1, 0.25, 0.5, 0.75, 1, 2.5, 5, 7.5, 10 }
             });
    })
    .WithTracing(tracing =>
    {
        tracing
            .SetResourceBuilder(ResourceBuilder.CreateDefault().AddService("PaymentService"))
            .AddAspNetCoreInstrumentation()
            .AddHttpClientInstrumentation()
            .AddOtlpExporter(otlpOptions =>
            {
                otlpOptions.Endpoint = new Uri("http://tempo:4317"); // Update to your Tempo OTLP endpoint
                otlpOptions.Protocol = OpenTelemetry.Exporter.OtlpExportProtocol.Grpc; // default
            });
    });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
    app.MapOpenApi();
    app.UseSwagger();
    app.UseSwaggerUI();
}

app.UseHttpsRedirection();
app.MapPrometheusScrapingEndpoint();

app.MapGet("/payment", async (IConfiguration config) =>
{
    var connectionString = config.GetConnectionString("MySql");
    var games = new List<object>();

    await using var connection = new MySqlConnection(connectionString);
    await connection.OpenAsync();

    var query = "SELECT game_id, title, platform, price, stock FROM game";
    await using var cmd = new MySqlCommand(query, connection);
    await using var reader = await cmd.ExecuteReaderAsync();

    while (await reader.ReadAsync())
    {
        games.Add(new
        {
            GameId = reader.GetInt32("game_id"),
            Title = reader.GetString("title"),
            Platform = reader.GetString("platform"),
            Price = reader.GetDecimal("price"),
            Stock = reader.GetInt32("stock")
        });
    }

    return Results.Ok(games);
});

app.MapControllers();
app.Run();
