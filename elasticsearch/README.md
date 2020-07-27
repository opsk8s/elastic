# Terraform Usage 

```hcl-terraform
locals {
  cluster_name = "es"
  es_version = "7.8.0"
  install_timeout = 180
  namespace = "es"
  storage_class = ""
  master_nodes = 1
  data_nodes = 1
  client_nodes = 1
  master_eligible_nodes = 1
}

provider "kubernetes" {
  load_config_file = "true"
}

resource "kubernetes_namespace" "es" {
  metadata {
    name = local.namespace
  }
}

module "elasticsearch_master" {
  source = "https://github.com/opsk8s/elastic/elasticsearch"
  cluster_name = local.cluster_name
  es_version = local.es_version
  node_group = "master"
  namespace = kubernetes_namespace.es.metadata[0].name
  storage_class_name = local.storage_class
  replicas = local.master_nodes
  storage_size = "5Gi"
  helm_install_timeout = local.install_timeout
  master_eligible_nodes = local.master_eligible_nodes
  roles = {
    master = true
    data = true
    ingest = true
  }
  common_annotations = {
    "janitor/ttl" = "10000d",
  }
}

module "elasticsearch_data" {
  source = "https://github.com/opsk8s/elastic/elasticsearch"
  cluster_name = local.cluster_name
  es_version = local.es_version
  node_group = "data"
  namespace = kubernetes_namespace.es.metadata[0].name
  storage_class_name = local.storage_class
  replicas = local.data_nodes
  storage_size = "50Gi"
  helm_install_timeout = local.install_timeout
  master_eligible_nodes = local.master_eligible_nodes
  roles = {
    master = false
    data = true
    ingest = false
  }
  common_annotations = {
    "janitor/ttl" = "10000d",
  }
}

module "elasticsearch_client" {
  source = "https://github.com/opsk8s/elastic/elasticsearch"
  cluster_name = local.cluster_name
  es_version = local.es_version
  node_group = "client"
  namespace = kubernetes_namespace.es.metadata[0].name
  replicas = local.client_nodes
  helm_install_timeout = local.install_timeout
  master_eligible_nodes = local.master_eligible_nodes
  roles = {
    master = false
    data = false
    ingest = true
  }
  common_annotations = {
    "janitor/ttl" = "10000d",
  }
}
```