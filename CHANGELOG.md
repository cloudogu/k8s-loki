# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]
### Changed
- [#10] Upgrade helm chart to 6.16.0 and loki to 3.1.1

### Fixed
- A bug where the gateway secret generates new every component upgrade.

## [v2.9.1-5] - 2024-09-18
### Changed
- [#8] Relicense to AGPL-3.0-only

## [v2.9.1-4] - 2023-12-13
### Fixed
- [#6] Fix structure of patch templates and add missing image for grafana operator.

## [v2.9.1-3] - 2023-12-06
### Added
- [#2] Add patch templates for using the chart in airgapped environments.
- [#4] Add default configuration for using k8s-minio and add shared secrets k8s-promtail to send data to k8s-loki

## [v2.9.1-2] - 2023-09-27
### Fixed
- Fix release to helm-registry

## [v2.9.1-1] - 2023-09-27
- initial release