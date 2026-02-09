apiVersion: v1
kind: ConfigMap
metadata:
  name: {{ .PROJECT_NAME }}-config
  namespace: default
data:
  config.yaml: |
    caller_interval: 10
  default.yaml: |
    web:
      - addr: 0.0.0.0:8080

    cluster:
      enable: True
      mode: single
      nodes:
        - name: localhost1
          ip: 127.0.0.1
          port: 9001
          local: true
        - name: localhost2
          ip: 127.0.0.1
          port: 9002
        - name: localhost3
          ip: 127.0.0.1
          port: 9003

    database:
      - dialect: mysql
        url: mysql-primary.app.svc.cluster.local:3306
        dbName: task_test
        user: test-user
        password: test-user
        debug: true
        charset: utf8mb4
        maxOpen: 200
        maxIdle: 20
        connMaxLifetime: 28800

    redis:
      - mode:
        addrs:
          - redis-master.app.svc.cluster.local:6379
        password: test
        readTimeout: 10s
        writeTimeout: 20s
        poolSize: 100
        minIdleConns: 20
        maxConnAge: 80s

    kafka:
      - name: testConsumer
        enable: true
        bootstrapServers:
          - kafaka-kafka.app.svc.cluster.local:9092
        groupId: testGroup4
        topics:
          - testTopic
        securityProtocol: SASL_PLAINTEXT
        saslMechanism: SCRAM-SHA-256
        saslUsername: user1
        saslPassword: test-user
        consumerAutoOffsetReset: earliest

    logger:
      level: TRACE
      trace: true
      timeFormat:
      path:
      fileName: app.log
      color: True
