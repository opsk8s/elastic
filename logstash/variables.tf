variable "helm_install_timeout" {
  type = number
  default = 600
  description = "Time in seconds to wait for any individual kubernetes operation (like Jobs for hooks)"
}
variable "es_version" {
  type = string
  description = "Elasticsearch version"
}

variable "namespace" {
  type = string
  description = "Namespace in which service will be deployed"
}

variable "name" {
  type = string
  default = "logstash"
}

variable "replicas" {
  type = number
  default = 1
  description = "Number of kibana replicas"
}

variable "logstash_config" {
  type = object({})
  default = {}
}

variable "logstash_pipeline" {
  type = object({})
  default = {}
}

variable "extra_envs" {
  type = object({
    name = string
    value = string
  })
  default = []
}

variable "env_form" {
  type = list(object({}))
  default = []
}

variable "secrets" {
  type = list(object({}))
  default = []
}

variable "secret_mounts" {
  type = list(object({}))
  default = []
}

variable "image" {
  type = string
  default = "docker.elastic.co/logstash/logstash"
}

variable "image_tag" {
  type = string
  default = "7.8.1-SNAPSHOT"
}

variable "image_pull_policy" {
  type = string
  default = "IfNotPresent"
}

variable "image_pull_secrets" {
  type = list(object({}))
  default = []
}

variable "labels" {
  type = object({})
  default = {}
}

variable "pod_annotations" {
  type = object({})
  default = {}
}

variable "java_options" {
  type = string
  default = "-Xmx1g -Xms1g"
}

variable "resources" {
  type = object({
    requests = object({
      cpu = string
      memory = string
    })
    limits = object({
      cpu = string
      memory = string
    })
  })

  default = {
    requests = {
      cpu = "100m"
      memory = "1536Mi"
    }
    limits = {
      cpu = "1000m"
      memory = "1536Mi"
    }
  }

  description = "Allows you to set the resources for the statefulset"
}

variable "volume_claim_template" {
  type = object({})
  default = {
    accessModes = [
      "ReadWriteOnce"]
    resources = {
      requests = {
        storage = "1Gi"
      }
    }
  }
}

variable "rbac" {
  type = object({})
  default = {
    create = false
    serviceAccountAnnotations = {}
    serviceAccountName = ""
  }
}

variable "pod_security_policy" {
  type = object({})
  default = {
    create = false
    name = ""
    spec = {
      privileged = true
      fsGroup = {
        rule = "RunAsAny"
      }
      runAsUser = {
        rule = "RunAsAny"
      }
      seLinux = {
        rule = "RunAsAny"
      }
      supplementalGroups = {
        rule = "RunAsAny"
      }
      volumes = [
        "secret",
        "configMap",
        "persistentVolumeClaim"
      ]
    }
  }
}

variable "persistence" {
  type = object({})
  default = {
    enabled = false
    annotations = {}
  }
}

variable "extra_volumes" {
  type = list(object({}))
  default = []
}

variable "extra_volume_mounts" {
  type = list(object({}))
  default = []
}

variable "extra_containers" {
  type = list(object({}))
  default = []
}

variable "extra_init_containers" {
  type = list(object({}))
  default = []
}

variable "priority_class_name" {
  type = string
  default = ""
}

variable "anti_affinity_topology_key" {
  type = string
  default = "kubernetes.io/hostname"
}

variable "anti_affinity" {
  type = string
  default = "soft"
}

variable "node_affinity" {
  type = object({})
  default = {}
}

variable "pod_management_policy" {
  type = string
  default = "Parallel"
}

variable "http_port" {
  type = number
  default = 9600
}

variable "extra_ports" {
  type = list(object({}))
  default = []
}

variable "update_strategy" {
  type = string
  default = "RollingUpdate"
}

variable "max_unavailable" {
  type = number
  default = 1
}

variable "pod_security_context" {
  type = object({})
  default = {}
}

variable "security_context" {
  type = object({})
  default = {}
}

variable "termination_grace_period" {
  type = number
  default = 120
}

variable "liveness_probe" {
  type = object({})
  default = {
    httpGet = {
      path = "/"
      port = "http"
    }
    initialDelaySeconds = 300
    periodSeconds = 10
    timeoutSeconds = 5
    failureThreshold = 3
    successThreshold = 1
  }
}

variable "readiness_probe" {
  type = object({})
  default = {
    httpGet = {
      path = "/"
      port = "http"
    }
    initialDelaySeconds = 60
    periodSeconds = 10
    timeoutSeconds = 5
    failureThreshold = 3
    successThreshold = 3
  }
}

variable "scheduler_name" {
  type = string
  default = ""
}

variable "node_selector" {
  type = object({})
  default = {}
}


variable "tolerations" {
  type = list(object({}))
  default = []
}

variable "name_override" {
  type = string
  default = ""
}

variable "full_name_override" {
  type = string
  default = ""
}

variable "lifecycle" {
  type = object({})
  default = {}
}