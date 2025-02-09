variable "aws_vpc_id" {
  description = "The AWS VPC ID"
  type        = string
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
}

variable "eks_cluster_role_arn" {
  description = "ARN of the IAM role to associate with the EKS cluster"
  type        = string
}

variable "eks_subnet_ids" {
  description = "Comma-separated list of subnet IDs where EKS should deploy worker nodes"
  type        = list(string)
}

variable "eks_node_group_name" {
  description = "The name of the EKS node group."
  type        = string
}

variable "eks_node_group_role" {
  description = "The IAM role ARN used for the EKS node group."
  type        = string
}

variable "eks_node_group_subnets" {
  description = "The subnets for the EKS node group."
  type        = list(string)
}

variable "eks_node_group_scaling_config" {
  description = "The scaling configuration for the EKS node group."
  type = object({
    desired_size = number
    max_size     = number
    min_size     = number
  })
}

variable "eks_node_group_ami_type" {
  description = "The AMI type for the EKS node group."
  type        = string
}

variable "eks_node_group_instance_types" {
  description = "The instance types for the EKS node group."
  type        = list(string)
}

variable "eks_node_group_capacity_type" {
  description = "The capacity type for the EKS node group."
  type        = string
}

variable "eks_node_group_disk_size" {
  description = "The disk size (in GiB) for the EKS node group instances."
  type        = number
}

variable "eks_node_group_access_key" {
  description = "The SSH key pair for remote access to the EKS node group instances."
  type        = string
}

variable "eks_cluster_security_group_name" {
  description = "The name of the EKS cluster security group"
  type        = string
}

variable "eks_cluster_security_group_description" {
  description = "The description of the EKS cluster security group"
  type        = string
}
