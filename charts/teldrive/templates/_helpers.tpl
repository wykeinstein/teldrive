{{/*
Expand the name of the chart.
*/}}
{{- define "teldrive.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "teldrive.fullname" -}}
{{- if .Values.fullnameOverride -}}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- $name := default .Chart.Name .Values.nameOverride -}}
{{- if contains $name .Release.Name -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
{{- end -}}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "teldrive.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels.
*/}}
{{- define "teldrive.labels" -}}
helm.sh/chart: {{ include "teldrive.chart" . }}
{{ include "teldrive.selectorLabels" . }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}

{{/*
Selector labels.
*/}}
{{- define "teldrive.selectorLabels" -}}
app.kubernetes.io/name: {{ include "teldrive.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end -}}

{{/*
Create the name of the service account to use.
*/}}
{{- define "teldrive.serviceAccountName" -}}
{{- if .Values.serviceAccount.create -}}
{{- default (include "teldrive.fullname" .) .Values.serviceAccount.name -}}
{{- else -}}
{{- default "default" .Values.serviceAccount.name -}}
{{- end -}}
{{- end -}}

{{/*
Return the config Secret name.
*/}}
{{- define "teldrive.configSecretName" -}}
{{- default (printf "%s-config" (include "teldrive.fullname" .)) .Values.existingConfigSecret -}}
{{- end -}}

{{/*
Render the Teldrive YAML config file from values.
*/}}
{{- define "teldrive.config" -}}
{{- toYaml .Values.config -}}
{{- end -}}
