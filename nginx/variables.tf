variable "namespace" {
    type = string
}


variable "kind" {
    type = string
    default = "deployment"
    description = "The kind of the Ingress controller installation - deployment or daemonset."
}


variable "nginxplus" {
    type = bool
    default = false
    description = "Deploys the Ingress controller for NGINX Plus."
}

variable "hostNetwork" {
    type = bool
    default = false
    description = "Enables the Ingress controller pods to use the host’s network namespace."
}

variable "logLevel" {
    type = number
    default = 1
    description = "The log level of the Ingress Controller."
}


variable "image" {
    type = object({
        repository = string
        tag = string
        pullPolicy = string
    })
    default = {
        repository = "nginx/nginx-ingress"
        tag = "edge"
        pullPolicy = "IfNotPresent"
    }
    description = <<EOF
    The image repository of the Ingress controller.
    The tag of the Ingress controller image.
    The pull policy for the Ingress controller image.
EOF
}


variable "config" {
    type = object({
        annotations = object({})
        entries = object({})
    })
    default = {
        annotations = {}
        entries = {}
    }
    description = <<EOF
    The name of the ConfigMap used by the Ingress controller.
    The entries of the ConfigMap for customizing NGINX configuration.
EOF
}

variable "customPorts" {
    type = list(number)
    default = []
    description = "A list of custom ports to expose on the NGINX ingress controller pod. Follows the conventional Kubernetes yaml syntax for container ports."
}

variable "defaultTLS" {
    type = object({
        cert = string
        key = string
        secret = string
    })
    default = {
        cert = "LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUN2akNDQWFZQ0NRREFPRjl0THNhWFhEQU5CZ2txaGtpRzl3MEJBUXNGQURBaE1SOHdIUVlEVlFRRERCWk8KUjBsT1dFbHVaM0psYzNORGIyNTBjbTlzYkdWeU1CNFhEVEU0TURreE1qRTRNRE16TlZvWERUSXpNRGt4TVRFNApNRE16TlZvd0lURWZNQjBHQTFVRUF3d1dUa2RKVGxoSmJtZHlaWE56UTI5dWRISnZiR3hsY2pDQ0FTSXdEUVlKCktvWklodmNOQVFFQkJRQURnZ0VQQURDQ0FRb0NnZ0VCQUwvN2hIUEtFWGRMdjNyaUM3QlBrMTNpWkt5eTlyQ08KR2xZUXYyK2EzUDF0azIrS3YwVGF5aGRCbDRrcnNUcTZzZm8vWUk1Y2Vhbkw4WGM3U1pyQkVRYm9EN2REbWs1Qgo4eDZLS2xHWU5IWlg0Rm5UZ0VPaStlM2ptTFFxRlBSY1kzVnNPazFFeUZBL0JnWlJVbkNHZUtGeERSN0tQdGhyCmtqSXVuektURXUyaDU4Tlp0S21ScUJHdDEwcTNRYzhZT3ExM2FnbmovUWRjc0ZYYTJnMjB1K1lYZDdoZ3krZksKWk4vVUkxQUQ0YzZyM1lma1ZWUmVHd1lxQVp1WXN2V0RKbW1GNWRwdEMzN011cDBPRUxVTExSakZJOTZXNXIwSAo1TmdPc25NWFJNV1hYVlpiNWRxT3R0SmRtS3FhZ25TZ1JQQVpQN2MwQjFQU2FqYzZjNGZRVXpNQ0F3RUFBVEFOCkJna3Foa2lHOXcwQkFRc0ZBQU9DQVFFQWpLb2tRdGRPcEsrTzhibWVPc3lySmdJSXJycVFVY2ZOUitjb0hZVUoKdGhrYnhITFMzR3VBTWI5dm15VExPY2xxeC9aYzJPblEwMEJCLzlTb0swcitFZ1U2UlVrRWtWcitTTFA3NTdUWgozZWI4dmdPdEduMS9ienM3bzNBaS9kclkrcUI5Q2k1S3lPc3FHTG1US2xFaUtOYkcyR1ZyTWxjS0ZYQU80YTY3Cklnc1hzYktNbTQwV1U3cG9mcGltU1ZmaXFSdkV5YmN3N0NYODF6cFErUyt1eHRYK2VBZ3V0NHh3VlI5d2IyVXYKelhuZk9HbWhWNThDd1dIQnNKa0kxNXhaa2VUWXdSN0diaEFMSkZUUkk3dkhvQXprTWIzbjAxQjQyWjNrN3RXNQpJUDFmTlpIOFUvOWxiUHNoT21FRFZkdjF5ZytVRVJxbStGSis2R0oxeFJGcGZnPT0KLS0tLS1FTkQgQ0VSVElGSUNBVEUtLS0tLQo="
        key = "LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBdi91RWM4b1JkMHUvZXVJTHNFK1RYZUprckxMMnNJNGFWaEMvYjVyYy9XMlRiNHEvClJOcktGMEdYaVN1eE9ycXgrajlnamx4NXFjdnhkenRKbXNFUkJ1Z1B0ME9hVGtIekhvb3FVWmcwZGxmZ1dkT0EKUTZMNTdlT1l0Q29VOUZ4amRXdzZUVVRJVUQ4R0JsRlNjSVo0b1hFTkhzbysyR3VTTWk2Zk1wTVM3YUhudzFtMApxWkdvRWEzWFNyZEJ6eGc2clhkcUNlUDlCMXl3VmRyYURiUzc1aGQzdUdETDU4cGszOVFqVUFQaHpxdmRoK1JWClZGNGJCaW9CbTVpeTlZTW1hWVhsMm0wTGZzeTZuUTRRdFFzdEdNVWozcGJtdlFmazJBNnljeGRFeFpkZFZsdmwKMm82MjBsMllxcHFDZEtCRThCay90elFIVTlKcU56cHpoOUJUTXdJREFRQUJBb0lCQVFDZklHbXowOHhRVmorNwpLZnZJUXQwQ0YzR2MxNld6eDhVNml4MHg4Mm15d1kxUUNlL3BzWE9LZlRxT1h1SENyUlp5TnUvZ2IvUUQ4bUFOCmxOMjRZTWl0TWRJODg5TEZoTkp3QU5OODJDeTczckM5bzVvUDlkazAvYzRIbjAzSkVYNzZ5QjgzQm9rR1FvYksKMjhMNk0rdHUzUmFqNjd6Vmc2d2szaEhrU0pXSzBwV1YrSjdrUkRWYmhDYUZhNk5nMUZNRWxhTlozVDhhUUtyQgpDUDNDeEFTdjYxWTk5TEI4KzNXWVFIK3NYaTVGM01pYVNBZ1BkQUk3WEh1dXFET1lvMU5PL0JoSGt1aVg2QnRtCnorNTZud2pZMy8yUytSRmNBc3JMTnIwMDJZZi9oY0IraVlDNzVWYmcydVd6WTY3TWdOTGQ5VW9RU3BDRkYrVm4KM0cyUnhybnhBb0dCQU40U3M0ZVlPU2huMVpQQjdhTUZsY0k2RHR2S2ErTGZTTXFyY2pOZjJlSEpZNnhubmxKdgpGenpGL2RiVWVTbWxSekR0WkdlcXZXaHFISy9iTjIyeWJhOU1WMDlRQ0JFTk5jNmtWajJTVHpUWkJVbEx4QzYrCk93Z0wyZHhKendWelU0VC84ajdHalRUN05BZVpFS2FvRHFyRG5BYWkyaW5oZU1JVWZHRXFGKzJyQW9HQkFOMVAKK0tZL0lsS3RWRzRKSklQNzBjUis3RmpyeXJpY05iWCtQVzUvOXFHaWxnY2grZ3l4b25BWlBpd2NpeDN3QVpGdwpaZC96ZFB2aTBkWEppc1BSZjRMazg5b2pCUmpiRmRmc2l5UmJYbyt3TFU4NUhRU2NGMnN5aUFPaTVBRHdVU0FkCm45YWFweUNweEFkREtERHdObit3ZFhtaTZ0OHRpSFRkK3RoVDhkaVpBb0dCQUt6Wis1bG9OOTBtYlF4VVh5YUwKMjFSUm9tMGJjcndsTmVCaWNFSmlzaEhYa2xpSVVxZ3hSZklNM2hhUVRUcklKZENFaHFsV01aV0xPb2I2NTNyZgo3aFlMSXM1ZUtka3o0aFRVdnpldm9TMHVXcm9CV2xOVHlGanIrSWhKZnZUc0hpOGdsU3FkbXgySkJhZUFVWUNXCndNdlQ4NmNLclNyNkQrZG8wS05FZzFsL0FvR0FlMkFVdHVFbFNqLzBmRzgrV3hHc1RFV1JqclRNUzRSUjhRWXQKeXdjdFA4aDZxTGxKUTRCWGxQU05rMXZLTmtOUkxIb2pZT2pCQTViYjhibXNVU1BlV09NNENoaFJ4QnlHbmR2eAphYkJDRkFwY0IvbEg4d1R0alVZYlN5T294ZGt5OEp0ek90ajJhS0FiZHd6NlArWDZDODhjZmxYVFo5MWpYL3RMCjF3TmRKS2tDZ1lCbyt0UzB5TzJ2SWFmK2UwSkN5TGhzVDQ5cTN3Zis2QWVqWGx2WDJ1VnRYejN5QTZnbXo5aCsKcDNlK2JMRUxwb3B0WFhNdUFRR0xhUkcrYlNNcjR5dERYbE5ZSndUeThXczNKY3dlSTdqZVp2b0ZpbmNvVlVIMwphdmxoTUVCRGYxSjltSDB5cDBwWUNaS2ROdHNvZEZtQktzVEtQMjJhTmtsVVhCS3gyZzR6cFE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo="
        secret = null
    }
    description = <<EOF
    The base64-encoded TLS certificate for the default HTTPS server. If not specified, a pre-generated self-signed certificate is used.
    Note: It is recommended that you specify your own certificate.

    The base64-encoded TLS key for the default HTTPS server.
    Note: If not specified, a pre-generated key is used. It is recommended that you specify your own key.

    The secret with a TLS certificate and key for the default HTTPS server.
    The value must follow the following format: <namespace>/<name>.
    Used as an alternative to specifying a certificate and key using controller.defaultTLS.cert and controller.defaultTLS.key parameters.
EOF
}

variable "wildcardTLS" {
    type = object({
        cert = string
        key = string
        secret = string
    })
    default = {
        key = ""
        cert = ""
        secret = null
    }
    description = <<EOF
    The base64-encoded TLS certificate for every Ingress host that has TLS enabled but no secret specified.
    If the parameter is not set, for such Ingress hosts NGINX will break any attempt to establish a TLS connection.

    The base64-encoded TLS key for every Ingress host that has TLS enabled but no secret specified.
    If the parameter is not set, for such Ingress hosts NGINX will break any attempt to establish a TLS connection.

    The secret with a TLS certificate and key for every Ingress host that has TLS enabled but no secret specified.
    The value must follow the following format: <namespace>/<name>. Used as an alternative to specifying a certificate and key using controller.wildcardTLS.cert and controller.wildcardTLS.key parameters.
EOF
}

variable "nodeSelector" {
    type = object({})
    default = {}
}

variable "terminationGracePeriodSeconds" {
    type = number
    default = 30
    description = "The termination grace period of the Ingress controller pod."
}

variable "tolerations" {
    type = list(object({
        key = string
        operator = string
        effect = string
    }))
    default = []
    description = "The tolerations of the Ingress controller pods."
}

# https://kubernetes.io/docs/tasks/configure-pod-container/assign-pods-nodes-using-node-affinity/
variable "affinity" {
    description = "	The affinity of the Ingress controller pods."
    type = object({})
    default = {}
}

# https://kubernetes.io/docs/concepts/storage/volumes/
variable "volumes" {
    description = "The volumes of the Ingress controller pods."
    type = list(object({}))
    default = []
}

# https://kubernetes.io/docs/concepts/storage/volumes/
variable "volumeMounts" {
    description = "The volumeMounts of the Ingress controller pods."
    type = list(object({
        mountPath = string
        mountPropagation = string
        name = string
        readOnly = bool
        subPath = string
        subPathExpr = string
    }))
    default = []
}

# https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/
variable "resources" {
    description = "	The resources of the Ingress controller pods."
    type = object({
       /*
        requests = object({
            memory = string
            cpu = string
        })
        limits = object({
            memory = string
            cpu = string
        })
        */
    })
    default = {}
}

variable "replicaCount" {
    description = "The number of replicas of the Ingress controller deployment."
    default = 1
}

variable "ingressClass" {
    description = <<EOF
    A class of the Ingress controller. The Ingress controller only processes Ingress resources that belong to its class - i.e.
    have the annotation "kubernetes.io/ingress.class" equal to the class. Additionally, the Ingress controller processes Ingress
    resources that do not have that annotation which can be disabled by setting the “-use-ingress-class-only” flag.
EOF
    type = string
    default = "nginx"
}

variable "useIngressClassOnly" {
    description = "Ignore Ingress resources without the kubernetes.io/ingress.class annotation."
    type = bool
    default = false
}

variable "watchNamespace" {
    description = "Namespace to watch for Ingress resources. By default the Ingress controller watches all namespaces."
    type = string
    default = ""
}

variable "enableCustomResources" {
    description = "Enable the custom resources."
    type = bool
    default = true
}

variable "enableTLSPassthrough" {
    description = "Enable TLS Passthrough on port 443. Requires controller.enableCustomResources."
    type = bool
    default = false
}

variable "healthStatus" {
    description = "Add a location “/nginx-health” to the default server. The location responds with the 200 status code for any request. Useful for external health-checking of the Ingress controller."
    type = bool
    default = false
}

variable "healthStatusURI" {
    description = "Sets the URI of health status location in the default server. Requires controller.healthStatus."
    type = string
    default = "/nginx-health"
}

variable "nginxStatus" {
    description = <<EOF
    enable - Enable the NGINX stub_status, or the NGINX Plus API.
    port - Set the port where the NGINX stub_status or the NGINX Plus API is exposed.
    allowCidrs - Whitelist IPv4 IP/CIDR blocks to allow access to NGINX stub_status or the NGINX Plus API. Separate multiple IP/CIDR by commas.
EOF
    type = object({
        enable = bool
        port = number
        allowCidrs = string
    })
    default = {
        enable = true
        port = 8080
        allowCidrs = "127.0.0.1"
    }
}


variable "service" {
    description = <<EOF
    create - Creates a service to expose the Ingress controller pods.
    type - The type of service to create for the Ingress controller.
    externalTrafficPolicy - The externalTrafficPolicy of the service. The value Local preserves the client source IP.
    annotations - The annotations of the Ingress controller service.
    loadBalancerIP - The static IP address for the load balancer. Requires controller.service.type set to LoadBalancer. The cloud provider must support this feature.
    externalIPs - The list of external IPs for the Ingress controller service.
    loadBalancerSourceRanges - The IP ranges (CIDR) that are allowed to access the load balancer. Requires controller.service.type set to LoadBalancer. The cloud provider must support this feature.
    name - The name of the service.
    customPorts - A list of custom ports to expose through the Ingress controller service. Follows the conventional Kubernetes yaml syntax for service ports.
    httpPort.enable - Enables the HTTP port for the Ingress controller service.
    httpPort.port - The HTTP port of the Ingress controller service.
    httpPort.nodePort - The custom NodePort for the HTTP port. Requires controller.service.type set to NodePort.
    httpPort.targetPort - The target port of the HTTP port of the Ingress controller service.
    httpsPort.enable - Enables the HTTPs port for the Ingress controller service.
    httpsPort.port - The HTTPs port of the Ingress controller service.
    httpsPort.nodePort - The custom NodePort for the HTTPs port. Requires controller.service.type set to NodePort.
    httpsPort.targetPort - The target port of the HTTPs port of the Ingress controller service.
EOF

    type = object({
        create = bool
        type = string
        externalTrafficPolicy = string
        annotations = object({})
        loadBalancerIP = string
        externalIPs = list(string)
        loadBalancerSourceRanges = list(string)
        customPorts = list(number)
        httpPort = object({
            enable = bool
            port = number
            nodePort = string
            targetPort = number
        })
        httpsPort = object({
            enable = bool
            port = number
            nodePort = string
            targetPort = number
        })
    })

    default = {
        create = true
        type = "LoadBalancer"
        externalTrafficPolicy = "Local"
        annotations = {}
        loadBalancerIP = ""
        externalIPs = []
        loadBalancerSourceRanges = []
        customPorts = []
        httpPort = {
            enable = true
            port = 80
            nodePort = ""
            targetPort = 80
        }
        httpsPort = {
            enable = true
            port = 433
            nodePort = ""
            targetPort = 433
        }
    }
}


variable "serviceAccount" {
    description = <<EOF
    name - The name of the service account of the Ingress controller pods. Used for RBAC.
    imagePullSecrets - The names of the secrets containing docker registry credentials.
EOF

    type = object({
        imagePullSecrets = list(object({
            name = string
        }))
    })
    default = {
        imagePullSecrets = []
    }
}

variable "reportIngressStatus" {
    description = <<EOF
    enable - Update the address field in the status of Ingresses resources with an external address of the Ingress controller.
             You must also specify the source of the external address either through an external service via controller.reportIngressStatus.externalService
             or the external-status-address entry in the ConfigMap via controller.config.entries. Note: controller.config.entries.external-status-address
             takes precedence if both are set.

    externalService - Specifies the name of the service with the type LoadBalancer through which the Ingress controller is exposed externally.
                      The external address of the service is used when reporting the status of Ingress resources. controller.reportIngressStatus.enable
                      must be set to true. The default is autogenerated and enabled when controller.service.create is set to true and controller.service.type
                      is set to LoadBalancer.

    enableLeaderElection - Enable Leader election to avoid multiple replicas of the controller reporting the status of Ingress resources.
                           controller.reportIngressStatus.enable must be set to true.

    leaderElectionLockName - Specifies the name of the ConfigMap, within the same namespace as the controller, used as the lock for leader election.
                             controller.reportIngressStatus.enableLeaderElection must be set to true.

EOF
    type = object({
        enable = bool
        enableLeaderElection = bool
        annotations = object({})
    })
    default = {
        enable = true
        enableLeaderElection = true
        annotations = {}
    }
}


variable "pod" {
    type = object({
        annotations = object({})
    })
    default = {
        annotations = {}
    }
}

variable "rbac" {
    type = bool
    default = true
}

variable "prometheus" {
    type = object({
        create = bool
        port = number
    })
    default = {
        create = false
        port = 9113
    }
}

variable "nginxReloadTimeout" {
    type = number
    default = 0
}

variable "appprotect" {
    type = object({})
    default = {
        enable = false
    }
}

variable "nginxDebug" {
    type = bool
    default = false
}


variable "globalConfiguration" {
    type = object({
        create = bool
        spec = object({
            listeners = list(object({
                name = string
                port = number
                protocol = string
            }))
        })
    })
    default = {
        create = false
        spec = {
            listeners = []
        }
    }
}

variable "enableSnippets" {
    type = bool
    default = false
}

variable "priorityClassName" {
    type = string
    default = null
}

variable "readyStatus" {
    type = object({
        enable = bool
        port = number
    })
    default =  {
        enable = true
        port = 8081
    }
}
