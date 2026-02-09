FROM centos:7-amd64
COPY ./{{ .PROJECT_NAME }} /usr/local/bin/

ENTRYPOINT ["/usr/local/bin/{{ .PROJECT_NAME }}","-config","/etc"]
