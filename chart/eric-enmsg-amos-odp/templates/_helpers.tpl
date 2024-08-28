{{/*
Generate WPServ Instances Dynamically
*/}}
{{- define "{{.Chart.Name}}.podsname" -}}
    {{- $release := .Release.Namespace -}}
    {{- "wpserv" }}.{{ $release }}.svc.cluster.local
{{- end -}}

{{/*
 Create image pull secrets
*/}}
{{- define "eric-enmsg-amos-odp.pullSecrets" -}}
{{- if .Values.global.registry.pullSecret -}}
{{- print .Values.global.pullSecret -}}
{{- else if .Values.imageCredentials.registry.pullSecret -}}
{{- print .Values.imageCredentials.pullSecret -}}
{{- end -}}
{{- end -}}

{{- define "eric-enmsg-amos-odp.service-ipv6" -}}
metadata:
  labels:
    service: {{ .Values.service.name }}-ipv6
  name: {{ .Values.service.name  }}-ipv6
{{- end -}}

{{- define "eric-enmsg-amos-odp.amos-odp-image" -}}
    {{- $values := first . -}}
    {{- $imagename := last . -}}
    {{- $registryUrl := index $values "imageCredentials" "registry" "url" -}}
    {{- $repoPath := index $values "imageCredentials" "repoPath" -}}
    {{- $name := index $values "images" $imagename "name" -}}
    {{- $tag := index $values "images" $imagename "tag" -}}
    {{- if $values.global -}}
        {{- if $values.global.registry -}}
            {{- if $values.global.registry.url -}}
                {{- $registryUrl = $values.global.registry.url -}}
            {{- end -}}
            {{- if $values.global.registry.repoPath -}}
                {{- $registryUrl = $values.global.registry.repoPath -}}
            {{- end -}}
        {{- end -}}
    {{- end -}}
    {{- printf "%s/%s/%s:%s" $registryUrl $repoPath $name $tag -}}
{{- end -}}