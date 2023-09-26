ARTIFACT_ID=k8s-loki
MAKEFILES_VERSION=8.4.0
VERSION=2.9.1-1

.DEFAULT_GOAL:=help

include build/make/variables.mk
include build/make/clean.mk
include build/make/release.mk
include build/make/self-update.mk

include build/make/k8s-component.mk

