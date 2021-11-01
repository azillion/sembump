# Setup name variables for the package/tool
NAME := sembump
PKG := github.com/azillion/$(NAME)

CGO_ENABLED := 0
VERSION :="1.1.2"

# Set any default go build tags.
BUILDTAGS :=

include basic.mk

.PHONY: prebuild
prebuild:

.PHONY: image-dev
image-dev:
	docker build --rm --force-rm -f Dockerfile.dev -t $(REGISTRY)/$(NAME):dev .

.PHONY: snakeoil
snakeoil: ## Update snakeoil certs for testing.
	go run /usr/local/go/src/crypto/tls/generate_cert.go --host localhost,127.0.0.1 --ca
	mv $(CURDIR)/key.pem $(CURDIR)/testutils/snakeoil/key.pem
	mv $(CURDIR)/cert.pem $(CURDIR)/testutils/snakeoil/cert.pem
