Set-Location -Path "C:\Users\Kohve\OneDrive\Desktop\OTEL demo\k8s"

# 1. Clean-up Minikube
Write-Output "`nCleaning up Kubernetes resources..."
kubectl delete -R -f .

# 3. Stop Minikube
Write-Output "`nStopping Minikube..."
minikube stop

Set-Location -Path "C:\Users\Kohve\OneDrive\Desktop\OTEL demo"