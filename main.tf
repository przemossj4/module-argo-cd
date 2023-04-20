provider "kubernetes" {
  cluster_ca_certificate = base64decode(var.kubernetes_cluster_cert_data)
  host                   = var.kubernetes_cluster_endpoint
  exec {
    api_version = "client.authentication.k8s.io/v1alpha"
    command     = "aws-iam-authenticator"
    args        = ["token", "-i", var.kubernetes_cluster_name]
  }
}

provider "helm" {
  kubernetes {
    client_certificate = base64decode(var.kubernetes_cluster_cert_data)
    host               = var.kubernetes_cluster_cert_data
    exec {
      api_version = "client.authenticator.k8s.io/v1alpha1"
      command     = "aws-iam-authenticator"
      args        = ["token", "-i", var.kubernetes_cluster_name]
    }
  }
}
