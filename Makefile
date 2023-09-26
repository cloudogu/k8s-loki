ARTIFACT_ID=k8s-loki
MAKEFILES_VERSION=8.4.0
VERSION=2.9.1-1

.DEFAULT_GOAL:=help

ADDITIONAL_CLEAN=clean_charts
clean_charts:
	rm -rf ${K8S_HELM_RESSOURCES}/charts

include build/make/variables.mk
include build/make/clean.mk
include build/make/release.mk
include build/make/self-update.mk

##@ Release

K8S_PRE_GENERATE_TARGETS=generate-release-resource
include build/make/k8s-component.mk

.PHONY: generate-release-resource
generate-release-resource: $(K8S_RESOURCE_TEMP_FOLDER)
	@cp manifests/loki.yaml ${K8S_RESOURCE_TEMP_YAML}

.PHONY: loki-release
loki-release: ## Interactively starts the release workflow for loki
	@echo "Starting git flow release..."
	@build/make/release.sh loki

##@ Helm dev targets
# Loki needs a copy of the targets from k8s.mk without image-import because we use an external image here.

.PHONY: ${K8S_HELM_RESSOURCES}/charts
${K8S_HELM_RESSOURCES}/charts: ${BINARY_HELM}
	@cd ${K8S_HELM_RESSOURCES} && ${BINARY_HELM} repo add grafana https://grafana.github.io/helm-charts && ${BINARY_HELM} dependency build

.PHONY: helm-loki-apply
helm-loki-apply: ${BINARY_HELM} ${K8S_HELM_RESSOURCES}/charts helm-generate $(K8S_POST_GENERATE_TARGETS) ## Generates and installs the helm chart.
	@echo "Apply generated helm chart"
	@${BINARY_HELM} upgrade -i ${ARTIFACT_ID} ${K8S_HELM_TARGET} --namespace ${NAMESPACE}

.PHONY: helm-loki-reinstall
helm-loki-reinstall: helm-delete helm-loki-apply ## Uninstalls the current helm chart and reinstalls it.

.PHONY: helm-loki-chart-import
helm-loki-chart-import: ${BINARY_HELM} ${K8S_HELM_RESSOURCES}/charts k8s-generate helm-generate-chart helm-package-release ## Pushes the helm chart to the k3ces registry.
	@echo "Import ${K8S_HELM_RELEASE_TGZ} into K8s cluster ${K3CES_REGISTRY_URL_PREFIX}..."
	@${BINARY_HELM} push ${K8S_HELM_RELEASE_TGZ} oci://${K3CES_REGISTRY_URL_PREFIX}/k8s ${BINARY_HELM_ADDITIONAL_PUSH_ARGS}
	@echo "Done."