$namespace = "default"    # Change this to your target namespace
$metricsPath = "metrics"  # Change if needed

# Get all services and their ports in the namespace
$services = kubectl get svc -n $namespace -o json | ConvertFrom-Json

foreach ($svc in $services.items) {
    $svcName = $svc.metadata.name
    $ports = $svc.spec.ports | ForEach-Object { $_.port }

    foreach ($port in $ports) {
        # Apply annotations per service and port
        kubectl annotate svc $svcName -n $namespace prometheus.io/scrape="true" --overwrite
        kubectl annotate svc $svcName -n $namespace prometheus.io/port="$port" --overwrite
        kubectl annotate svc $svcName -n $namespace prometheus.io/path="$metricsPath" --overwrite

        Write-Host "✅ Annotated service '$svcName' on port $port"
    }
}

Write-Host "`n✅ Finished annotating all services in namespace '$namespace'."
