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
            filebeatConfig = var.filebeat_config
            extraEnvs = var.extra_envs
            extraVolumeMounts = var.extra_volume_mounts
            extraVolumes = var.extra_volumes
            extraContainers = var.extra_containers
            extraInitContainers = var.extra_init_containers
            envFrom = var.env_form
            hostPathRoot = var.host_path_root
            hostNetworking = var.host_networking
            image = var.image
            imageTag = var.image_tag
            imagePullPolicy = var.image_pull_policy
            imagePullSecrets = var.image_pull_secrets
            livenessProbe = var.liveness_probe
            readinessProbe = var.readiness_probe
            managedServiceAccount = var.managed_service_account
            labels = var.labels
            podAnnotations = var.pod_annotations
            podSecurityContext = var.pod_security_context
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
        })
    ]
}
