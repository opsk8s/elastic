terraform {
    required_version = ">= 0.12"
}

resource "helm_release" "elasticsearch" {
    chart = "${path.module}/charts"
    version = var.es_version
    name = var.name
    namespace = var.namespace
    timeout = var.helm_install_timeout
    values = [
        yamlencode({
            elasticsearchHosts = var.hosts
            replicas = var.replicas
            extraEnvs = var.extra_envs
            envFrom = var.env_form
            secretMounts = var.secret_mounts
            image = var.image
            imageTag = var.image_tag
            imagePullPolicy = var.image_pull_policy
            labels = var.labels
            podAnnotations = var.pod_annotations
            resources = var.resources
            protocol = var.protocol
            serverHost = var.server_host
            healthCheckPath = var.health_check_path
            kibanaConfig = var.kibana_config
            podSecurityContext = var.pod_security_context
            serviceAccount = var.service_account
            priorityClassName = var.priority_class_name
            httpPort = var.http_port
            extraContainers = var.extra_containers
            extraInitContainers = var.extra_init_containers
            updateStrategy = var.update_strategy
            service = var.service
            ingress = var.ingress
            readinessProbe = var.readiness_probe
            imagePullSecrets = var.image_pull_secrets
            nodeSelector = var.node_selector
            tolerations = var.tolerations
            nameOverride = var.name_override
            fullnameOverride = var.full_name_override
            lifecycle = var.lifecycle
            elasticsearchURL = var.elasticsearch_url
        })
    ]
}
