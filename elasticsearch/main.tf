terraform {
  required_version = ">= 0.12"
}

resource "helm_release" "elasticsearch" {
  chart = "${path.module}/charts"
  version = var.es_version
  name = local.full_name_override
  namespace = var.namespace
  timeout = var.helm_install_timeout

  values = [
    yamlencode({
      clusterName = var.cluster_name
      nodeGroup = var.node_group
      fullnameOverride = local.full_name_override
      masterService = local.master_service
      esConfig = var.es_config
      protocol = var.protocol
      httpPort = var.http_port
      commonAnnotations = var.common_annotations
      podAnnotations = local.pod_annotations
      roles = local.roles
      image = var.image
      replicas = local.replicas
      imagePullSecrets = var.image_pull_secrets
      minimumMasterNodes = local.minimum_master_nodes
      terminationGracePeriod = var.termination_grace_period
      resources = var.resources
      ingress = var.ingress
      persistence = {
        enabled = local.persistance_enabled
        labels = {
          enabled = false
        }
        annotations = {}
      }
      extraServicePorts = var.extra_service_ports
      extraConfigs = var.extra_configs
      tolerations = var.tolerations
      nodeSelector = var.node_selector
      esJavaOpts = var.es_java_opts
      extraVolumes = var.extra_volumes
      extraContainers = var.extra_containers
      keystore = var.keystore
    })
  ]
  
  set {
    name = "volumeClaimTemplate.storageClassName"
    value = var.storage_class_name
  }

  set {
    name = "volumeClaimTemplate.resources.requests.storage"
    value = var.storage_size
  }

}
