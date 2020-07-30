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
            apmConfig = var.apm_config
            replicas = var.replicas
            extraContainers = var.extra_containers
            extraInitContainers = var.extra_init_containers
            extraEnvs = var.extra_envs
            envFrom = var.env_form
            extraVolumes = var.extra_volumes
            extraVolumeMounts = var.extra_volume_mounts
            image = var.image
            imageTag = var.image_tag
            imagePullPolicy = var.image_pull_policy
            imagePullSecrets = var.image_pull_secrets
            managedServiceAccount = var.managed_service_account
            podAnnotations = var.pod_annotations
            labels = var.labels
            podSecurityContext = var.pod_security_context
            livenessProbe = var.liveness_probe
            readinessProbe = var.readiness_probe
            resources = var.resources
            serviceAccount = var.service_account
            serviceAccountAnnotations = var.service_account_annotations
            secretMounts = var.secret_mounts
            terminationGracePeriod = var.termination_grace_period
            tolerations = var.tolerations
            nodeSelector = var.node_selector
            affinity = var.affinity
            priorityClassName = var.priority_class_name
            updateStrategy = var.update_strategy
            nameOverride = var.name_override
            fullnameOverride = var.full_name_override
            autoscaling = var.autoscaling
            ingress = var.ingress
            service = var.service
            lifecycle = var.lifecycle
        })
    ]
}
