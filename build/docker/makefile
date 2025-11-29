# Go parameters
GOBUILD=GO111MODULE=on go build
GOCLEAN=GO111MODULE=on go clean
BINARY_NAME=demo-api
COMMITID=$(shell git rev-parse HEAD | cut -c1-6)
IMAGE_NAME=register/demo-api:$(COMMITID)

# Default target
all: build

# Build for current platform
build:
	$(GOBUILD) -o $(BINARY_NAME) -v ../..

# Clean build artifacts
clean:
	$(GOCLEAN)
	rm -f $(BINARY_NAME)
	docker rmi $(IMAGE_NAME) || true

# Build for Linux platform
linux:
	CGO_ENABLED=0 GOOS=linux GOARCH=amd64 $(GOBUILD) -o $(BINARY_NAME) -v ../..

# Build Docker image
image: linux
	docker buildx build --platform linux/amd64 -t $(IMAGE_NAME) .

# Upload Docker image
upload: image
	docker push $(IMAGE_NAME)

# Run the application
run:
	go run ../..

# Run tests
test:
	go test -v ../..