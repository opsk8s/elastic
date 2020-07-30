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

variable "hosts" {
    type = list(string)
    default = [
        "http://elasticsearch-master:9200"
    ]
    description = "Elasticsearch hosts"
}

variable "replicas" {
    type = number
    default = 1
    description = "Number of kibana replicas"
}

variable "extra_envs" {
    type = object({
        name = string
        value = string
    })
    default = [
        {
            name = "NODE_OPTIONS"
            value = "--max-old-space-size=1800"
        }
    ]
}

variable "env_form" {
    type = list(object({}))
    default = []
}

variable "secret_mounts" {
    type = list(object({}))
    default = []
}

variable "image" {
    type = string
    default = "docker.elastic.co/kibana/kibana"
}

variable "image_tag" {
    type = string
    default = "7.8.1-SNAPSHOT"
}

variable "image_pull_policy" {
    type = string
    default = "IfNotPresent"
}

variable "labels" {
    type = object({})
    default = {}
}

variable "pod_annotations" {
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
            cpu = "1000m"
            memory = "2Gi"
        }
        limits = {
            cpu = "1000m"
            memory = "2Gi"
        }
    }

    description = "Allows you to set the resources for the statefulset"
}

variable "protocol" {
    type = string
    default = "http"
}

variable "server_host" {
    type = string
    default = "0.0.0.0"
}

variable "health_check_path" {
    type = string
    default = "/app/kibana"
}

variable "kibana_config" {
    type = object({})
    default = {}
}

variable "pod_security_context" {
    type = object({})
    default = {}
}

variable "service_account" {
    type = string
    default = ""
}

variable "priority_class_name" {
    type = string
    default = ""
}

variable "http_port" {
    type = number
    default = 5601
}

variable "extra_containers" {
    type = object({})
    default = {}
}

variable "extra_init_containers" {
    type = object({})
    default = {}
}

variable "update_strategy" {
    type = object({})
    default = {
        type: "Recreate"
    }
}

variable "service" {
    type = object({})
    default = {
        type = ClusterIP
        loadBalancerIP = ""
        port = 5601
        nodePort = ""
        labels = {}
        annotations = {}
        loadBalancerSourceRanges = []
    }
}

variable "ingress" {
    type = object({})
    default = {
        enabled = false
        annotations = {}
        path = "/"
        hosts = [
            "chart-example.local"
        ]
        tls: []
    }
}

variable "readiness_probe" {
    type = object({})
    default = {
        failureThreshold: 3
        initialDelaySeconds: 10
        periodSeconds: 10
        successThreshold: 3
        timeoutSeconds: 5
    }
}

variable "image_pull_secrets" {
    type = list(object({}))
    default = []
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

variable "elasticsearch_url" {
    type = string
    default = ""
}