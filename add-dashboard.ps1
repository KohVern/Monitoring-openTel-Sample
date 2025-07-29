set-location -path "C:\Users\Kohve\OneDrive\Desktop\OTEL demo\k8s\Grafana"

# Dynamically find all .json files in dashboards directory
$files = Get-ChildItem -Path dashboards -Filter *.json | ForEach-Object {"--from-file=$($_.FullName)"}

# Create configmap with all files
kubectl create configmap grafana-dashboards $files --dry-run=client -o yaml > grafana-dashboards.yaml
