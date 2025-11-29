# Kubernetes Deployment for Test API

This directory contains Kubernetes manifests to deploy the Test API application.

## Components

1. **Namespace**: Isolates resources in the `demo-api` namespace
2. **ConfigMap**: Contains application configuration files
3. **Deployment**: Runs the application with resource limits (2 CPU, 4GB memory)
4. **Service**: Exposes the application internally within the cluster

## Deployment Instructions

### Prerequisites
- Kubernetes cluster
- kubectl configured

### Deploy

```bash
# Apply all resources
kubectl apply -k .

# Or apply individually
kubectl apply -f namespace.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
```

### Access the Application

After deployment, the application will be accessible at:
- Within cluster: `http://demo-api-service.demo-api.svc.cluster.local`

### Resource Limits

The deployment is configured with:
- CPU Limit: 2 cores
- Memory Limit: 4GB
- CPU Request: 1 core
- Memory Request: 2GB

These limits ensure consistent performance testing results.