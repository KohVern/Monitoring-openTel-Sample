# Commands
## Apply/Delete
- `docker build -t [service]:latest .`
- `minikube image load [service]:latest`
- `kubectl apply -R -f . `
- `kubectl delete -R -f .`
- `kubectl port-forward deployments/grafana 3000:3000`
# Otel-collector
## Steps
- Ensure docker desktop is on
- Have minikube
```cmd
./start.ps1
./stop.ps1
```
- Apply the Otel folder contents into kubernetes.
- Add ServiceMonitoring to the monitoring folder
- Add : Labels: target-allocation: “true” to the (Service files)

## View UI
```cmd
kubectl port-forward svc/otel-collector-targetallocator 8080:80
```


## Scaling Otel-collector (StatefulSet)
Example:
```cmd
kubectl patch opentelemetrycollector otel-collector -n default --type=merge -p '{\"spec\":{\"replicas\":3}}'

```

# Grafana - Dashboards
- Obtain dashboard .json files
- Put inside 'k8s/Grafana/dashboards'
- Run `./add-dashboard.ps1`
- `grafana-dashboard.yaml` should be updated

# S3 implementation
```
storage:
  trace:
    backend: s3
    s3:
        bucket: [bucket_name]
        endpoint: s3.amazonaws.com
        region: ap-southeast-1
        access_key: [access_key]
        secret_key: [secret_key]

## Delete

volumeMounts:
  - name: tempo-storage
    mountPath: /tmp/tempo
volumes:
  - name: tempo-storage
    persistentVolumeClaim:
      claimName: tempo-pvc
```
