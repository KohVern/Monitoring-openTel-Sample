# Annotate node-exporter service for Prometheus scraping
kubectl annotate svc weather-api-service prometheus.io/scrape="true" --overwrite
kubectl annotate svc weather-api-service prometheus.io/port="5170" --overwrite
kubectl annotate svc weather-api-service prometheus.io/path="metrics" --overwrite
kubectl annotate svc payment-api-service prometheus.io/scrape="true" --overwrite
kubectl annotate svc payment-api-service prometheus.io/port="5180" --overwrite
kubectl annotate svc payment-api-service prometheus.io/path="metrics" --overwrite
kubectl annotate svc cadvisor prometheus.io/scrape="true" --overwrite
kubectl annotate svc cadvisor prometheus.io/port="8080" --overwrite
kubectl annotate svc cadvisor prometheus.io/path="metrics" --overwrite
kubectl annotate svc node-exporter prometheus.io/scrape="true" --overwrite
kubectl annotate svc node-exporter prometheus.io/port="9100" --overwrite
kubectl annotate svc node-exporter prometheus.io/path="metrics" --overwrite

Write-Host "Annotations applied to service: node-exporter"
