export DOCKER_BUILDKIT := 1

BIN     := dotfiles
# VERSION := $(shell git describe --tags --always --dirty)
VERSION := alpha
IMAGE   := docker.pkg.github.com/pbar1/dotfiles/$(BIN)

image:
	docker build . -t $(IMAGE):$(VERSION) -t $(IMAGE):latest

image-push: image
	docker push $(IMAGE):$(VERSION)
	docker push $(IMAGE):latest
