ARTIFACT_ID=k8s-loki
GOTAG=1.26.0
MAKEFILES_VERSION=10.6.0
VERSION=3.5.10-2

.DEFAULT_GOAL:=help

ADDITIONAL_CLEAN=clean_charts
clean_charts:
	rm -rf ${K8S_HELM_RESSOURCES}/charts

include build/make/variables.mk
include build/make/clean.mk
include build/make/release.mk
include build/make/self-update.mk

##@ Release

include build/make/k8s-component.mk

.PHONY: loki-release
loki-release: ## Interactively starts the release workflow for loki
	@echo "Starting git flow release..."
	@build/make/release.sh loki
