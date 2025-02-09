terraform {
  backend "s3" {
    bucket = "hackaton-video-processor-infra-terraform-state"
    key    = "eks-cluster/terraform.tfstate"
    region = "us-east-1"
    profile = "default"
  }
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "~> 2.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "default"
  default_tags {
    tags = {
      Group = "hackaton-7soat"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

module "ecr" {
  source = "./modules/ecr"
  ecr_repository_video_processor_api_name = var.ecr_repository_video_processor_api_name
  ecr_repository_video_processor_worker_name = var.ecr_repository_video_processor_worker_name
}

module "kubernetes-infra" {
  source = "./modules/kubernetes-infra"
  aws_vpc_id = var.aws_vpc_id
  eks_cluster_security_group_name = var.eks_cluster_security_group_name
  eks_cluster_security_group_description = var.eks_cluster_security_group_description
  eks_cluster_name = var.eks_cluster_name
  eks_cluster_role_arn = var.eks_cluster_role_arn
  eks_subnet_ids = var.eks_subnet_ids
  eks_node_group_name = var.eks_node_group_name
  eks_node_group_role = var.eks_node_group_role
  eks_node_group_subnets = var.eks_node_group_subnets
  eks_node_group_scaling_config = var.eks_node_group_scaling_config
  eks_node_group_instance_types = var.eks_node_group_instance_types
  eks_node_group_ami_type = var.eks_node_group_ami_type
  eks_node_group_capacity_type = var.eks_node_group_capacity_type
  eks_node_group_disk_size = var.eks_node_group_disk_size
  eks_node_group_access_key = var.eks_node_group_access_key
  
  depends_on = [module.ecr]
}

module "kubernetes-drivers" {
  source = "./modules/kubernetes-drivers"
  depends_on = [module.kubernetes-infra]
}

module "lambda" {
  source = "./modules/lambda"

  aws_secrets_name                                  = var.aws_secrets_name
  lambda_role_name                                  = var.lambda_role_name
  lambda_execution_policy_name                      = var.lambda_execution_policy_name
  user_accounts_lambda_function_name                = var.user_accounts_lambda_function_name
  user_accounts_lambda_function_handler             = var.user_accounts_lambda_function_handler
  user_accounts_lambda_function_runtime             = var.user_accounts_lambda_function_runtime
  user_accounts_lambda_function_filename            = var.user_accounts_lambda_function_filename
  user_accounts_lambda_function_memory_size         = var.user_accounts_lambda_function_memory_size
  user_accounts_lambda_function_timeout             = var.user_accounts_lambda_function_timeout
  email_service_lambda_function_name                = var.email_service_lambda_function_name
  email_service_lambda_function_handler             = var.email_service_lambda_function_handler
  email_service_lambda_function_runtime             = var.email_service_lambda_function_runtime
  email_service_lambda_function_filename            = var.email_service_lambda_function_filename
  email_service_lambda_function_memory_size         = var.email_service_lambda_function_memory_size
  email_service_lambda_function_timeout             = var.email_service_lambda_function_timeout
}

module "cognito" {
  source = "./modules/cognito"

  cognito_database_name                                      = var.cognito_database_name
  cognito_database_password_policy_minimum_length            = var.cognito_database_password_policy_minimum_length
  cognito_database_password_policy_require_uppercase         = var.cognito_database_password_policy_require_uppercase
  cognito_database_password_policy_require_lowercase         = var.cognito_database_password_policy_require_lowercase
  cognito_database_password_policy_require_numbers           = var.cognito_database_password_policy_require_numbers
  cognito_database_password_policy_require_symbols           = var.cognito_database_password_policy_require_symbols
  cognito_database_password_policy_temporary_password_validity_days = var.cognito_database_password_policy_temporary_password_validity_days
  cognito_database_auto_verified_attributes                  = var.cognito_database_auto_verified_attributes
  cognito_database_account_recovery_setting_recovery_mechanism_name = var.cognito_database_account_recovery_setting_recovery_mechanism_name
  cognito_database_account_recovery_setting_recovery_mechanism_priority = var.cognito_database_account_recovery_setting_recovery_mechanism_priority
  cognito_database_admin_create_user_config_allow_admin_create_user_only = var.cognito_database_admin_create_user_config_allow_admin_create_user_only
  cognito_database_email_configuration_email_sending_account = var.cognito_database_email_configuration_email_sending_account
  cognito_database_user_pool_name                            = var.cognito_database_user_pool_name
  cognito_database_user_pool_generate_secret                 = var.cognito_database_user_pool_generate_secret
  cognito_database_user_pool_explicit_auth_flows             = var.cognito_database_user_pool_explicit_auth_flows
  cognito_database_user_pool_refresh_token_validity          = var.cognito_database_user_pool_refresh_token_validity
}

module "s3" {
  source = "./modules/s3"

  bucket_name_video_files                = var.bucket_name_video_files
  bucket_tags_video_files                = var.bucket_tags_video_files
  bucket_name_video_images_files         = var.bucket_name_video_images_files
  bucket_tags_video_images_files         = var.bucket_tags_video_images_files
  versioning_status                      = var.versioning_status
  encryption_algorithm                   = var.encryption_algorithm
  block_public_acls                      = var.block_public_acls
  block_public_policy                    = var.block_public_policy
  ignore_public_acls                     = var.ignore_public_acls
  restrict_public_buckets                = var.restrict_public_buckets
}

module "api-gateway" {
  source = "./modules/api-gateway"

  api_gateway_name                                        = var.api_gateway_name
  api_gateway_protocol_type                               = var.api_gateway_protocol_type
  api_gateway_lambda_permission_statement_id              = var.api_gateway_lambda_permission_statement_id
  api_gateway_lambda_permission_action                    = var.api_gateway_lambda_permission_action
  api_gateway_lambda_permission_function_name             = var.api_gateway_lambda_permission_function_name
  api_gateway_lambda_permission_principal                 = var.api_gateway_lambda_permission_principal
  api_gateway_lambda_integration_integration_type         = var.api_gateway_lambda_integration_integration_type
  api_gateway_lambda_integration_integration_uri          = var.api_gateway_lambda_integration_integration_uri
  api_gateway_lambda_integration_payload_format_version   = var.api_gateway_lambda_integration_payload_format_version
  
  cognito_user_pool_user_accounts_id                      = module.cognito.cognito_user_pool_user_accounts_id
  cognito_user_pool_client_user_accounts_id               = module.cognito.cognito_user_pool_client_user_accounts_id

  api_gateway_video_processor_api_integration_type   = var.api_gateway_video_processor_api_integration_type
  api_gateway_video_processor_api_integration_method = var.api_gateway_video_processor_api_integration_method
  api_gateway_video_processor_api_connection_type    = var.api_gateway_video_processor_api_connection_type
  api_gateway_video_processor_api_integration_uri    = var.api_gateway_video_processor_api_integration_uri
  api_gateway_auto_deploy                                 = var.api_gateway_auto_deploy

  depends_on = [module.cognito]
}

module "sns-sqs" {
  source = "./modules/sns-sqs"

  aws_account_id                      = var.aws_account_id

  video_processor_api_queue_dlq_name                       = var.video_processor_api_queue_dlq_name
  video_processor_api_queue_dlq_delay_seconds              = var.video_processor_api_queue_dlq_delay_seconds
  video_processor_api_dlq_max_message_size                 = var.video_processor_api_dlq_max_message_size
  video_processor_api_dlq_message_retention_seconds        = var.video_processor_api_dlq_message_retention_seconds
  video_processor_api_dlq_receive_wait_time_seconds        = var.video_processor_api_dlq_receive_wait_time_seconds
  video_processor_api_dlq_visibility_timeout_seconds       = var.video_processor_api_dlq_visibility_timeout_seconds

  video_processor_api_queue_name                           = var.video_processor_api_queue_name
  video_processor_api_queue_delay_seconds                  = var.video_processor_api_queue_delay_seconds
  video_processor_api_queue_max_message_size               = var.video_processor_api_queue_max_message_size
  video_processor_api_queue_message_retention_seconds      = var.video_processor_api_queue_message_retention_seconds
  video_processor_api_queue_receive_wait_time_seconds      = var.video_processor_api_queue_receive_wait_time_seconds
  video_processor_api_queue_visibility_timeout_seconds     = var.video_processor_api_queue_visibility_timeout_seconds

  video_processor_api_redrive_policy_max_receive_count     = var.video_processor_api_redrive_policy_max_receive_count

  video_processor_worker_queue_dlq_name                       = var.video_processor_worker_queue_dlq_name
  video_processor_worker_queue_dlq_delay_seconds              = var.video_processor_worker_queue_dlq_delay_seconds
  video_processor_worker_dlq_max_message_size                 = var.video_processor_worker_dlq_max_message_size
  video_processor_worker_dlq_message_retention_seconds        = var.video_processor_worker_dlq_message_retention_seconds
  video_processor_worker_dlq_receive_wait_time_seconds        = var.video_processor_worker_dlq_receive_wait_time_seconds
  video_processor_worker_dlq_visibility_timeout_seconds       = var.video_processor_worker_dlq_visibility_timeout_seconds

  video_processor_worker_queue_name                           = var.video_processor_worker_queue_name
  video_processor_worker_queue_delay_seconds                  = var.video_processor_worker_queue_delay_seconds
  video_processor_worker_queue_max_message_size               = var.video_processor_worker_queue_max_message_size
  video_processor_worker_queue_message_retention_seconds      = var.video_processor_worker_queue_message_retention_seconds
  video_processor_worker_queue_receive_wait_time_seconds      = var.video_processor_worker_queue_receive_wait_time_seconds
  video_processor_worker_queue_visibility_timeout_seconds     = var.video_processor_worker_queue_visibility_timeout_seconds

  video_processor_worker_redrive_policy_max_receive_count     = var.video_processor_worker_redrive_policy_max_receive_count

  video_processor_api_topic_name      = var.video_processor_api_topic_name
  video_processor_worker_topic_name   = var.video_processor_worker_topic_name

  aws_lambda_function_email_service_arn = module.lambda.aws_lambda_function_email_service_arn

  depends_on = [module.lambda]
}


########################################################################
# Outputs
########################################################################
output "ecr_repository_video_processor_api_uri" {
  value = module.ecr.ecr_repository_video_processor_api_uri
}

output "ecr_repository_video_processor_worker_uri" {
  value = module.ecr.ecr_repository_video_processor_worker_uri
}

output "cognito_user_pool_user_accounts_id" {
  value = module.cognito.cognito_user_pool_user_accounts_id
}

output "cognito_user_pool_client_user_accounts_id" {
  value = module.cognito.cognito_user_pool_client_user_accounts_id
}

output "cognito_user_pool_client_user_accounts_name" {
  value = module.cognito.cognito_user_pool_client_user_accounts_name
}

output "s3_bucket_video_files_name" {
  value = module.s3.s3_bucket_video_files_name
}

output "s3_bucket_video_files_uri" {
  value = module.s3.s3_bucket_video_files_uri
}

output "s3_bucket_video_files_arn" {
  value = module.s3.s3_bucket_video_files_arn
}

output "s3_bucket_video_images_files_name" {
  value = module.s3.s3_bucket_video_images_files_name
}

output "s3_bucket_video_images_files_uri" {
  value = module.s3.s3_bucket_video_images_files_uri
}

output "s3_bucket_video_images_files_arn" {
  value = module.s3.s3_bucket_video_images_files_arn
}

output "aws_sqs_queue_video_processor_api_dlq_name" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_api_dlq_name
}

output "aws_sqs_queue_video_processor_api_dlq_arn" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_api_dlq_arn
}

output "aws_sqs_queue_video_processor_api_name" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_api_name
}

output "aws_sqs_queue_video_processor_api_arn" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_api_arn
}

output "aws_sqs_queue_video_processor_worker_dlq_name" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_worker_dlq_name
}

output "aws_sqs_queue_video_processor_worker_dlq_arn" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_worker_dlq_arn
}

output "aws_sqs_queue_video_processor_worker_name" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_worker_name
}

output "aws_sqs_queue_video_processor_worker_arn" {
  value = module.sns-sqs.aws_sqs_queue_video_processor_worker_arn
}

output "aws_sns_topic_video_processor_api_name" {
  value = module.sns-sqs.aws_sns_topic_video_processor_api_name
}

output "aws_sns_topic_video_processor_api_arn" {
  value = module.sns-sqs.aws_sns_topic_video_processor_api_arn
}

output "aws_sns_topic_video_processor_worker_name" {
  value = module.sns-sqs.aws_sns_topic_video_processor_worker_name
}

output "aws_sns_topic_video_processor_worker_arn" {
  value = module.sns-sqs.aws_sns_topic_video_processor_worker_arn
}

output "aws_lambda_function_user_accounts_url" {
  value = module.lambda.aws_lambda_function_user_accounts_url
}

output "aws_lambda_function_email_service_url" {
  value = module.lambda.aws_lambda_function_email_service_url
}

output "aws_eks_cluster_hackaton_endpoint" {
  value = module.kubernetes-infra.aws_eks_cluster_hackaton_endpoint
}

output "aws_eks_cluster_hackaton_arn" {
  value = module.kubernetes-infra.aws_eks_cluster_hackaton_arn
}
