# k8s-loki betreiben

## Installation

`k8s-loki` kann als Komponente über den Komponenten-Operator des CES installiert werden.
Dazu muss eine entsprechende Custom-Resource (CR) für die Komponente erstellt werden.

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
```

Die neue yaml-Datei kann anschließend im Kubernetes-Cluster erstellt werden:

```shell
kubectl apply -f k8s-loki.yaml --namespace ecosystem
```

Der Komponenten-Operator erstellt nun die `k8s-loki`-Komponente im `ecosystem`-Namespace.

## Upgrade

Zum Upgrade muss die gewünschte Version in der Custom-Resource angegeben werden.
Dazu wird die erstellte CR yaml-Datei editiert und die gewünschte Version eingetragen.
Anschließend die editierte yaml Datei erneut auf den Cluster anwenden:

```shell
kubectl apply -f k8s-loki.yaml --namespace ecosystem
```

## Konfiguration

Die Komponente kann über das Feld `spec.valuesYamlOverwrite`. Die Konfigurationsmöglichkeiten entsprechen denen von
[Grafana Loki](https://grafana.com/docs/loki/latest/setup/install/helm/reference/).
Die Konfiguration für das "Grafana Loki" Helm-Chart muss in der `values.yaml` unter dem Key `loki` abgelegt werden.

**Beispiel:**
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
  valuesYamlOverwrite: |
    loki:
      write:
        replicas: 3
      read:
        replicas: 3
      backend:
        replicas: 3
```

### Zusätzliche Konfiguration

Neben der oben beschriebenen Standard-Konfiguration von Loki, verfügt die `k8s-loki`-Komponente über zusätzliche
Konfiguration:

| Parameter             | Beschreibung                                                                                                                                            | Default-Wert              |
|-----------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------|---------------------------|
| lokiGatewaySecretName | Der Name des K8S-Secrets, das erzeugt wird um Username und Passwort für den Loki-Gateway für  z.B. `k8s-promtail` und `k8s-ces-control` bereitzustellen | `k8s-loki-gateway-secret` |

