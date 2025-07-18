kubectl apply -R -f . 
kubectl delete -R -f . 

Note: Currently the tempo-querier starts up faster than the tempo-frontend hence current solution is to manually restart it

TODO: 
- Look into holding it, restarting automatically
- App currently sending direct to tempo
- Try to send to otel-col then tempo

## Add this for S3 implementation and delete PersistentVolume
```cmd
storage:
  trace:
    backend: s3
    s3:
        bucket: [bucket_name]
        endpoint: s3.amazonaws.com
        region: ap-southeast-1
        access_key: [access_key]
        secret_key: [secret_key]```

- Can be Deleted

volumeMounts:
  - name: tempo-storage
    mountPath: /tmp/tempo
volumes:
  - name: tempo-storage
    persistentVolumeClaim:
      claimName: tempo-pvc
