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
      replicas = var.replicas
      logstashConfig = var.logstash_config
      logstashPipeline = var.logstash_pipeline
      extraEnvs = var.extra_envs
      envFrom = var.env_form
      secrets = var.secrets
      secretMounts = var.secret_mounts
      image = var.image
      imageTag = var.image_tag
      imagePullPolicy = var.image_pull_policy
      imagePullSecrets = var.image_pull_secrets
      podAnnotations = var.pod_annotations
      labels = var.labels
      logstashJavaOpts = var.java_options
      resources = var.resources
      volumeClaimTemplate = var.volume_claim_template
      rbac = var.rbac
      podSecurityPolicy = var.pod_security_policy
      persistence = var.persistence
      extraVolumes = var.extra_volumes
      extraVolumeMounts = var.extra_volume_mounts
      extraContainers = var.extra_containers
      extraInitContainers = var.extra_init_containers
      priorityClassName = var.priority_class_name
      antiAffinityTopologyKey = var.anti_affinity_topology_key
      antiAffinity = var.anti_affinity
      nodeAffinity = var.node_affinity
      podManagementPolicy = var.pod_management_policy
      httpPort = var.http_port
      extraPorts = var.extra_ports
      updateStrategy = var.update_strategy
      maxUnavailable = var.max_unavailable
      podSecurityContext = var.pod_security_context
      securityContext = var.security_context
      terminationGracePeriod = var.termination_grace_period
      livenessProbe = var.liveness_probe
      readinessProbe = var.readiness_probe
      schedulerName = var.scheduler_name
      nodeSelector = var.node_selector
      tolerations = var.tolerations
      nameOverride = var.name_override
      fullnameOverride = var.full_name_override
      lifecycle = var.lifecycle
    })
  ]
}
