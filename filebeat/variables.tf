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
  default = "kibana"
}

variable "filebeat_config" {
  type = map(string)
  default = {
    "filebeat.yml" = <<EOT
filebeat.inputs:
- type: container
  paths:
    - /var/log/containers/*.log
  processors:
  - add_kubernetes_metadata:
      host: \${NODE_NAME}
      matchers:
      - logs_path:
          logs_path: "/var/log/containers/"

output.elasticsearch:
  host: '\${NODE_NAME}'
  hosts: '\${ELASTICSEARCH_HOSTS:elasticsearch-master:9200}'
EOT
  }
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

variable "extra_volume_mounts" {
  type = list(object({}))
  default = []
}

variable "extra_volumes" {
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

variable "host_path_root" {
  type = string
  default = "/var/lib"
}

variable "host_networking" {
  type = bool
  default = false
}


variable "image" {
  type = string
  default = "docker.elastic.co/apm/apm-server"
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

variable "liveness_probe" {
  type = object({})
  default = {
    exec = {
      command = [
        "sh",
        "-c",
        "#!/usr/bin/env bash -e\ncurl --fail 127.0.0.1:5066"
      ]
    }
    failureThreshold = 3
    initialDelaySeconds = 10
    periodSeconds = 10
    timeoutSeconds = 5
  }
}

variable "readiness_probe" {
  type = object({})
  default = {
    command = [
      "sh",
      "-c",
      "#!/usr/bin/env bash -e\nfilebeat test output"
    ]
  }
  failureThreshold = 3
  initialDelaySeconds = 10
  periodSeconds = 10
  timeoutSeconds = 5
}

variable "managed_service_account" {
  type = bool
  default = true
}

variable "labels" {
  type = object({})
  default = {}
}

variable "pod_annotations" {
  type = object({})
  default = {}
}

variable "pod_security_context" {
  type = object({})
  default = {}
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
      memory = "100Mi"
    }
    limits = {
      cpu = "1000m"
      memory = "200Mi"
    }
  }

  description = "Allows you to set the resources for the statefulset"
}

variable "service_account" {
  type = string
  default = ""
}

variable "service_account_annotations" {
  type = object({})
  default = {}
}

variable "secret_mounts" {
  type = list(object({}))
  default = []
}

variable "termination_grace_period" {
  type = number
  default = 30
}

variable "tolerations" {
  type = list(object({}))
  default = []
}

variable "node_selector" {
  type = object({})
  default = {}
}

variable "affinity" {
  type = object({})
  default = {}
}

variable "priority_class_name" {
  type = string
  default = ""
}

variable "update_strategy" {
  type = object({})
  default = {
    type: "Recreate"
  }
}

variable "name_override" {
  type = string
  default = ""
}

variable "full_name_override" {
  type = string
  default = ""
}
