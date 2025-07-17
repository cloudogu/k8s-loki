# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [v3.3.2-3] - 2025-07-17
### Changed
- [#24] Update Makefiles to 10.2.0
### Added 
- [#24] Configure Log-Level for sidecars via Value-Mapping

## [v3.3.2-2] - 2025-04-24
### Changed
- [#22] Set sensible resource requests and limits

## [v3.3.2-1] - 2025-01-06
### Changed
- [#20] Update loki helm chart to 6.24.0 to fix CVE-2024-45337

## [v3.1.1-5] - 2024-12-10
### Added
- [#18] NetworkPolicy to allow only internal ingress traffic
  - Dependent Dogus and Components must bring their own NetworkPolicy to access Loki
- [#18] Ingress Network Policy for MinIO so that Loki can access it

## [v3.1.1-4] - 2024-11-13
### Changed
- [#16] Disable sidecar to load rules from ConfigMaps/Secrets.
  - This improves security as it also removes cluster-wide permissions for ConfigMaps/Secrets.

## [v3.1.1-3] - 2024-10-28
### Changed
- [#14] Use `ces-container-registries` secret for pulling container images as default.

## [v3.1.1-2] - 2024-10-17
### Fixed
- [#12] Path for lokiCanary image in patch templates.

## [v3.1.1-1] - 2024-10-07
## Added
- [#10] Docs how to disable IPv6 with the component custom resource. This is useful in IPv4-only systems.
 
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
