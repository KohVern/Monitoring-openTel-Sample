## Apply/Delete
```cmd
kubectl apply -R -f . 
kubectl delete -R -f .
```
# Otel-collector
## Steps
```cmd 
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml 
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

TODO:
- Try implement CR locally for easy startup
- Add More Service Monitoring

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
