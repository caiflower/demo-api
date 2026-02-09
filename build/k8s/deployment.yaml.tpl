apiVersion: apps/v1
kind: Deployment
metadata:
  name: {{ .PROJECT_NAME }}
  namespace: {{ .PROJECT_NAME }}
  labels:
    app: {{ .PROJECT_NAME }}
spec:
  replicas: 1
  selector:
    matchLabels:
      app: {{ .PROJECT_NAME }}
  template:
    metadata:
      labels:
        app: {{ .PROJECT_NAME }}
    spec:
      containers:
      - name: {{ .PROJECT_NAME }}
        image: lijinlong100-cn-north-1.jcr.service.jdcloud.com/{{ .PROJECT_NAME }}:latest
        command:
          - /usr/local/bin/{{ .PROJECT_NAME }} -config /etc/{{ .PROJECT_NAME }}
        ports:
        - containerPort: 8080
        env:
        - name: GOMAXPROCS
          value: "2"
        resources:
          limits:
            cpu: "2"
            memory: 4Gi
          requests:
            cpu: "1"
            memory: 2Gi
        livenessProbe:
          httpGet:
            path: /metrics
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /metrics
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 5
        volumeMounts:
        - name: config-volume
          mountPath: /etc/{{ .PROJECT_NAME }}
      volumes:
      - name: config-volume
        configMap:
          name: {{ .PROJECT_NAME }}-config
