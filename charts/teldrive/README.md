# Teldrive Helm chart

This chart deploys Teldrive on Kubernetes with a configurable Service and optional Ingress.

## Install

Create a values file with your required Teldrive settings:

```yaml
config:
  db:
    data-source: "postgres://teldrive:secret@postgres:5432/teldrive?sslmode=disable"
  jwt:
    allowed-users:
      - your_telegram_username
    secret: "replace-with-a-random-secret"
  server:
    port: 8080
  tg:
    uploads:
      encryption-key: "replace-with-a-random-key"

ingress:
  enabled: true
  className: nginx
  hosts:
    - host: teldrive.example.com
      paths:
        - path: /
          pathType: Prefix
  tls:
    - secretName: teldrive-tls
      hosts:
        - teldrive.example.com
```

Install the chart:

```sh
helm install teldrive ./charts/teldrive -f values.yaml
```

## Configuration

| Value | Description | Default |
| --- | --- | --- |
| `image.repository` | Teldrive image repository | `ghcr.io/tgdrive/teldrive` |
| `image.tag` | Image tag. Defaults to chart `appVersion` when empty | `""` |
| `config` | Teldrive YAML config rendered into a Kubernetes Secret | minimal config |
| `existingConfigSecret` | Existing Secret name to mount instead of rendering `config` | `""` |
| `existingConfigSecretKey` | Secret key containing the config file | `config.yml` |
| `service.type` | Kubernetes Service type | `ClusterIP` |
| `service.port` | Kubernetes Service port | `8080` |
| `ingress.enabled` | Create an Ingress resource | `false` |
| `ingress.className` | IngressClass name | `""` |
| `ingress.annotations` | Extra ingress annotations | `{}` |
| `ingress.hosts` | Ingress hosts and paths | `teldrive.local` |
| `ingress.tls` | Ingress TLS entries | `[]` |

## Existing config Secret

If you manage the Teldrive config separately, create a Secret with a `config.yml` key and set:

```yaml
existingConfigSecret: my-teldrive-config
existingConfigSecretKey: config.yml
```
