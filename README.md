# Monitoring-openTel-Sample

Sample weather,payment service with Cadvisor, node-exporter to be scrapped by otel-collector for Prometheus, traced by Tempo, visualized by Grafana

## Pre-requisites
- Docker
- Minikube image
- kubectl
- [.NET 9.0](https://dotnet.microsoft.com/en-us/download/dotnet/9.0)

## Services: [port]
- Weather-App   : 5170
- Payment-App   : 5180
- cAdvisor      : 8080
- Node-Exporter : 9100
- otel-collector: 8889
- Prometheus    : 9090
- Grafana       : 3000
- mySQL         : 3306
- mySQL-Exporter: 9104

## Usage in Main branch
### Docker-Compose
```cmd
docker-compose up
```
Be sure to run Wamp-Server for mySQL @ port: 3306
- Adjust passwords accordingly (this is for POC)
## Usage in branch k8s-poc
### Minikube (Kubernetes)
- Use separate terminals
---
Load image into minikube
[In weather directory]
```cmd
docker build -t weather-api:latest
minikube image load weather-api:latest
```
[In payment directory]
```cmd
docker build -t payment-api:latest
minikube image load payment-api:latest
```
Start up minikube and run pods
```cmd
Minikube start
kubectl apply -f .
kubectl port-forward deploy/otel-collector 8889:8889
minikube service weather-api-service //'/test' endpoint to test traceability
kubectl port-forward svc/tempo 4317:4317 4318:4318 3200:3200
minikube dashboard
```

### Docker-Compose
```cmd
docker-compose up
```

### Connecting datasource
- Prometheus
- Tempo (Be sure to go to Additional Settings and add to 'Service graph' your prometheus datasource)
  - Enable node graph to view
## Grafana sample dashboards

- Cluster monitoring: 315
- cAdvisor metrics  : 19792
- Node exporter     : 1860
- SQL-Metrics       : 14057
