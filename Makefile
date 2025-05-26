# Variables
DOCKER_REGISTRY=hub.p1.cn
WEB_IMAGE=$(DOCKER_REGISTRY)/prod/infra-dify-web
API_IMAGE= $(DOCKER_REGISTRY)/prod/infra-dify-api
SHA := $(shell git rev-parse HEAD | head -c 8)
DATE := $(shell date +%Y%m%d%H%M%S)
VERSION := $(SHA)-$(DATE)


# Build Docker images
build-web:
	@echo "Building web Docker image: $(WEB_IMAGE):$(VERSION)..."
	docker build -t $(WEB_IMAGE):$(VERSION) ./web
	@echo "Web Docker image built successfully: $(WEB_IMAGE):$(VERSION)"

build-api:
	@echo "Building API Docker image: $(API_IMAGE):$(VERSION)..."
	docker build -t $(API_IMAGE):$(VERSION) ./api
	@echo "API Docker image built successfully: $(API_IMAGE):$(VERSION)"

# Push Docker images
push-web:
	@echo "Pushing web Docker image: $(WEB_IMAGE):$(VERSION)..."
	docker push $(WEB_IMAGE):$(VERSION)
	@echo "Web Docker image pushed successfully: $(WEB_IMAGE):$(VERSION)"

push-api:
	@echo "Pushing API Docker image: $(API_IMAGE):$(VERSION)..."
	docker push $(API_IMAGE):$(VERSION)
	@echo "API Docker image pushed successfully: $(API_IMAGE):$(VERSION)"

# Clear Docker images
clear-web:
	@echo "Clearing API Docker image: $(WEB_IMAGE):$(VERSION)..."
	docker rmi -f $(WEB_IMAGE):$(VERSION)

clear-api:
	@echo "Clearing API Docker image: $(API_IMAGE):$(VERSION)..."
	docker rmi -f $(API_IMAGE):$(VERSION)

# Build all images
build-all: build-web build-api

# Push all images
push-all: push-web push-api

# Clear all images
clear-all: clear-web clear-api

build-push-api: build-api push-api clear-api
build-push-web: build-web push-web clear-web

# Build and push all images
build-push-all: build-all push-all clear-all
	@echo "All Docker images have been built and pushed."

# Phony targets
.PHONY: build-web build-api push-web push-api build-all push-all build-push-all
