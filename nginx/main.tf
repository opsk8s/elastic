terraform {
    required_version = ">= 0.12"
}

resource "helm_release" "nginx-ingress" {
    repository = "${path.module}/charts"
    chart = "nginx-ingress"
    name = "es"
    version = "0.5.2"
    namespace = var.namespace
    values = [
        yamlencode({
            controller = {
                kind = var.kind
                nginxplus = var.nginxplus
                nginxReloadTimeout = var.nginxReloadTimeout
                appprotect = var.appprotect
                hostNetwork = var.hostNetwork
                nginxDebug = var.nginxDebug
                logLevel = var.logLevel
                customPorts = var.customPorts
                image = var.image
                defaultTLS = var.defaultTLS
                wildcardTLS = var.wildcardTLS
                nodeSelector = var.nodeSelector
                terminationGracePeriodSeconds = var.terminationGracePeriodSeconds
                resources = var.resources
                tolerations = var.tolerations
                affinity = var.affinity
                volumes = var.volumes
                volumeMounts = var.volumeMounts
                replicaCount = var.replicaCount
                ingressClass = var.ingressClass
                useIngressClassOnly = var.useIngressClassOnly
                watchNamespace = var.watchNamespace
                enableCustomResources = var.enableCustomResources
                enableTLSPassthrough = var.enableTLSPassthrough
                globalConfiguration = var.globalConfiguration
                enableSnippets = var.enableSnippets
                healthStatus = var.healthStatus
                healthStatusURI = var.healthStatusURI
                nginxStatus = var.nginxStatus
                service = var.service
                serviceAccount = var.serviceAccount
                reportIngressStatus = var.reportIngressStatus
                pod = var.pod
                priorityClassName = var.priorityClassName
                readyStatus = var.readyStatus
            }
            rbac = {
                create = var.rbac
            }
            prometheus = var.prometheus
        })
    ]
}
