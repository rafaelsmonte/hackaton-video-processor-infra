#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Install necessary drivers on kubernetes infrastructure
#============================================================================

#============================================================================
# Activity: Install metrics server
# Description: Metrics server is responsible to collect metrics for HPA
#============================================================================
resource "helm_release" "metrics_server" {
  name       = "metrics-server"
  repository = "https://kubernetes-sigs.github.io/metrics-server/"
  chart      = "metrics-server"
}

#============================================================================
# Activity: Install external secrets
# Description: External secrets is responsible for integration with AWS
#              secrets manager
#============================================================================
resource "helm_release" "external_secrets" {
  name       = "external-secrets"
  repository = "https://charts.external-secrets.io"
  chart      = "external-secrets"
}

#============================================================================
# Activity: Install csi driver
# Description: AWS driver to expose EBS features to EKS Kubernetes pods resources
#============================================================================
/* resource "helm_release" "ebs_csi_driver" {
  name       = "ebs-csi-driver"
  repository = "https://kubernetes-sigs.github.io/aws-ebs-csi-driver"
  chart      = "aws-ebs-csi-driver"
} */

#============================================================================
# Activity: Install cluster auto scale
# Description: Deploys a pod with autoscaler service to allow kubernetes running on EKS
#              to be able to adjust de node group auto scalling group in order to provision
#              more EC2 instances when compute resources are limited
#============================================================================
resource "aws_iam_role" "eks_cluster_autoscaler" {
  name = "EKSClusterAutoscalerRole"
  assume_role_policy = file("./add-ons/autoscaler/cluster-autoscaler-aws-role.json")
}
resource "aws_iam_role_policy_attachment" "eks_cluster_autoscaler" {
  role       = aws_iam_role.eks_cluster_autoscaler.name
  policy_arn = "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  depends_on = [aws_iam_role.eks_cluster_autoscaler]
}

resource "kubernetes_manifest" "cluster_autoscaler_service_account" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-service-account.yaml"))
}
resource "kubernetes_manifest" "cluster_autoscaler_cluster_role" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-cluster-role.yaml"))
}
resource "kubernetes_manifest" "cluster_autoscaler_role" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-role.yaml"))
}
resource "kubernetes_manifest" "cluster_autoscaler_cluster_role_binding" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-cluster-role-binding.yaml"))
}
resource "kubernetes_manifest" "cluster_autoscaler_role_binding" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-role-binding.yaml"))
}
resource "kubernetes_manifest" "cluster_autoscaler_deployment" {
  manifest = yamldecode(file("./add-ons/autoscaler/cluster-autoscaler-deployment.yaml"))
}
