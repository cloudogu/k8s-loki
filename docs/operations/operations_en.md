# operate k8s-loki

## Installation

`k8s-loki` can be installed as a component via the CES component operator.
To do this, a corresponding custom resource (CR) must be created for the component.

```yaml
apiVersion: k8s.cloudogu.com/v1
kind: Component
metadata:
  name: k8s-loki
  labels:
    app: ces
spec:
  name: k8s-loki
  namespace: k8s
  version: 2.9.1-2
```

The new yaml file can then be created in the Kubernetes cluster:
```shell
kubectl apply -f k8s-loki.yaml --namespace ecosystem
```

The component operator now creates the `k8s-loki` component in the `ecosystem` namespace.

## Upgrade

To upgrade, the desired version must be specified in the custom resource.
To do this, the CR yaml file created is edited and the desired version is entered.
Then apply the edited yaml file to the cluster again:
```shell
kubectl apply -f k8s-loki.yaml --namespace ecosystem
```

## Configuration

The component can be overwritten via the `spec.valuesYamlOverwrite` field. The configuration options correspond to those of
[Grafana Loki](https://grafana.com/docs/loki/latest/setup/install/helm/reference/).
