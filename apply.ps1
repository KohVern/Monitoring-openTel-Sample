Set-Location -Path "C:\Users\Kohve\OneDrive\Desktop\OTEL demo\k8s"

# 1. Install Cert-Manager (CRDs + components)
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.crds.yaml
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/latest/download/cert-manager.yaml

# 2. Wait for cert-manager to be ready
Write-Output "`nWaiting for cert-manager pods to be ready..."
kubectl wait --for=condition=ready pod -l app=webhook -n cert-manager --timeout=90s
kubectl wait --for=condition=ready pod -l app=cert-manager -n cert-manager --timeout=90s

# 3. Install OpenTelemetry Operator
kubectl apply -f https://github.com/open-telemetry/opentelemetry-operator/releases/latest/download/opentelemetry-operator.yaml

# 4. Wait for OTel operator webhook/controller pod to be ready
Write-Output "`nWaiting for OpenTelemetry Operator pod to be ready..."
kubectl wait --for=condition=ready pod -l control-plane=controller-manager -n opentelemetry-operator-system --timeout=120s

# 5. Install Prometheus CRDs (optional, for ServiceMonitor / PodMonitor support)
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.69/example/prometheus-operator-crd/monitoring.coreos.com_servicemonitors.yaml
kubectl apply -f https://raw.githubusercontent.com/prometheus-operator/prometheus-operator/release-0.69/example/prometheus-operator-crd/monitoring.coreos.com_podmonitors.yaml

# 6. Apply the rest of your manifests
Write-Output "`nApplying user manifests..."
kubectl apply -R -f .
