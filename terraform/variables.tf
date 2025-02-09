########################################################################
# AWS Account
########################################################################
variable "aws_vpc_id" {
  description = "The AWS VPC ID"
  type        = string
}

variable "aws_account_id" {
  description = "AWS account ID for topic access policies."
  type        = string
}

########################################################################
# ECR Repositories
########################################################################
variable "ecr_repository_video_processor_api_name" {
  description = "Name of the ECR repository for the Video Processor API."
  type        = string
}

variable "ecr_repository_video_processor_worker_name" {
  description = "Name of the ECR repository for the Video Processor Worker."
  type        = string
}

########################################################################
# Cognito Database
########################################################################
variable "cognito_database_name" {
  type        = string
  description = "The name of the Cognito database."
}

variable "cognito_database_password_policy_minimum_length" {
  type        = number
  description = "The minimum length for passwords in the Cognito database."
}

variable "cognito_database_password_policy_require_uppercase" {
  type        = bool
  description = "Whether to require uppercase letters in passwords."
}

variable "cognito_database_password_policy_require_lowercase" {
  type        = bool
  description = "Whether to require lowercase letters in passwords."
}

variable "cognito_database_password_policy_require_numbers" {
  type        = bool
  description = "Whether to require numbers in passwords."
}

variable "cognito_database_password_policy_require_symbols" {
  type        = bool
  description = "Whether to require symbols in passwords."
}

variable "cognito_database_password_policy_temporary_password_validity_days" {
  type        = number
  description = "The number of days temporary passwords are valid."
}

variable "cognito_database_auto_verified_attributes" {
  type        = list(string)
  description = "The attributes that Cognito automatically verifies."
}

variable "cognito_database_account_recovery_setting_recovery_mechanism_name" {
  type        = string
  description = "The recovery mechanism name for account recovery."
}

variable "cognito_database_account_recovery_setting_recovery_mechanism_priority" {
  type        = number
  description = "The priority of the account recovery mechanism."
}

variable "cognito_database_admin_create_user_config_allow_admin_create_user_only" {
  type        = bool
  description = "Whether to allow only administrators to create users."
}

variable "cognito_database_email_configuration_email_sending_account" {
  type        = string
  description = "The email sending account configuration."
}

variable "cognito_database_user_pool_name" {
  type        = string
  description = "The name of the Cognito user pool."
}

variable "cognito_database_user_pool_generate_secret" {
  type        = bool
  description = "Whether to generate a client secret for the user pool."
}

variable "cognito_database_user_pool_explicit_auth_flows" {
  type        = list(string)
  description = "The explicit authentication flows allowed for the user pool."
}

variable "cognito_database_user_pool_refresh_token_validity" {
  type        = number
  description = "The number of days the refresh token is valid."
}

########################################################################
# S3
########################################################################
variable "bucket_name_video_files" {
  description = "The name of the S3 bucket for video files."
  type        = string
  default     = "storage-video-files"
}

variable "bucket_tags_video_files" {
  description = "Tags to associate with the S3 bucket."
  type        = map(string)
  default = {
    Name = "storage-video-files"
  }
}

variable "bucket_name_video_images_files" {
  description = "The name of the S3 bucket for video files."
  type        = string
  default     = "storage-video-files"
}

variable "bucket_tags_video_images_files" {
  description = "Tags to associate with the S3 bucket."
  type        = map(string)
  default = {
    Name = "storage-video-files"
  }
}

variable "versioning_status" {
  description = "The versioning status for the S3 bucket."
  type        = string
  default     = "Enabled"
}

variable "encryption_algorithm" {
  description = "The SSE algorithm for server-side encryption."
  type        = string
  default     = "AES256"
}

variable "block_public_acls" {
  description = "Whether to block public ACLs for the S3 bucket."
  type        = bool
  default     = false
}

variable "block_public_policy" {
  description = "Whether to block public policies for the S3 bucket."
  type        = bool
  default     = false
}

variable "ignore_public_acls" {
  description = "Whether to ignore public ACLs for the S3 bucket."
  type        = bool
  default     = false
}

variable "restrict_public_buckets" {
  description = "Whether to restrict public buckets for the S3 bucket."
  type        = bool
  default     = false
}

########################################################################
# SQS and SNS
########################################################################
variable "video_processor_api_queue_dlq_name" {
  description = "Name of the DLQ for the video processor API."
  type        = string
}

variable "video_processor_api_queue_dlq_delay_seconds" {
  description = "Delay in seconds for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_api_dlq_max_message_size" {
  description = "Maximum message size in bytes for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_api_dlq_message_retention_seconds" {
  description = "Retention period in seconds for messages in the DLQ of the video processor API."
  type        = number
}

variable "video_processor_api_dlq_receive_wait_time_seconds" {
  description = "Wait time in seconds for message retrieval from the DLQ of the video processor API."
  type        = number
}

variable "video_processor_api_dlq_visibility_timeout_seconds" {
  description = "Visibility timeout in seconds for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_api_queue_name" {
  description = "Name of the SQS queue for the video processor API."
  type        = string
}

variable "video_processor_api_queue_delay_seconds" {
  description = "Delay in seconds for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_api_queue_max_message_size" {
  description = "Maximum message size in bytes for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_api_queue_message_retention_seconds" {
  description = "Retention period in seconds for messages in the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_api_queue_receive_wait_time_seconds" {
  description = "Wait time in seconds for message retrieval from the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_api_queue_visibility_timeout_seconds" {
  description = "Visibility timeout in seconds for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_api_redrive_policy_max_receive_count" {
  description = "Maximum receive count for the redrive policy of the video processor API queue."
  type        = number
}

variable "video_processor_worker_queue_dlq_name" {
  description = "Name of the DLQ for the video processor API."
  type        = string
}

variable "video_processor_worker_queue_dlq_delay_seconds" {
  description = "Delay in seconds for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_worker_dlq_max_message_size" {
  description = "Maximum message size in bytes for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_worker_dlq_message_retention_seconds" {
  description = "Retention period in seconds for messages in the DLQ of the video processor API."
  type        = number
}

variable "video_processor_worker_dlq_receive_wait_time_seconds" {
  description = "Wait time in seconds for message retrieval from the DLQ of the video processor API."
  type        = number
}

variable "video_processor_worker_dlq_visibility_timeout_seconds" {
  description = "Visibility timeout in seconds for the DLQ of the video processor API."
  type        = number
}

variable "video_processor_worker_queue_name" {
  description = "Name of the SQS queue for the video processor API."
  type        = string
}

variable "video_processor_worker_queue_delay_seconds" {
  description = "Delay in seconds for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_worker_queue_max_message_size" {
  description = "Maximum message size in bytes for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_worker_queue_message_retention_seconds" {
  description = "Retention period in seconds for messages in the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_worker_queue_receive_wait_time_seconds" {
  description = "Wait time in seconds for message retrieval from the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_worker_queue_visibility_timeout_seconds" {
  description = "Visibility timeout in seconds for the SQS queue of the video processor API."
  type        = number
}

variable "video_processor_worker_redrive_policy_max_receive_count" {
  description = "Maximum receive count for the redrive policy of the video processor API queue."
  type        = number
}

variable "video_processor_api_topic_name" {
  description = "The name of the SNS topic for the video processor API."
  type        = string
}

variable "video_processor_worker_topic_name" {
  description = "The name of the SNS topic for the video processor Worker."
  type        = string
}

########################################################################
# Lambda Function
########################################################################
variable "lambda_role_name" {
  description = "The name of the IAM role for Lambda execution."
  type        = string
}

variable "lambda_execution_policy_name" {
  description = "The name of the policy for the Lambda execution role."
  type        = string
}

variable "aws_secrets_name" {
  description = "The name of the Secrets Manager secret."
  type        = string
}

variable "user_accounts_lambda_function_name" {
  description = "The name of the user accounts Lambda function."
  type        = string
}

variable "user_accounts_lambda_function_handler" {
  description = "The handler for the user accounts Lambda function."
  type        = string
}

variable "user_accounts_lambda_function_runtime" {
  description = "The runtime for the user accounts Lambda function."
  type        = string
}

variable "user_accounts_lambda_function_memory_size" {
  description = "The memory size for the user accounts Lambda function."
  type        = number
}

variable "user_accounts_lambda_function_timeout" {
  description = "The timeout for the user accounts Lambda function."
  type        = number
}

variable "user_accounts_lambda_function_filename" {
  description = "The file path with lambda function code."
  type        = string
}

variable "email_service_lambda_function_name" {
  description = "The name of the Lambda function for the email service."
  type        = string
}

variable "email_service_lambda_function_handler" {
  description = "The handler for the email service Lambda function."
  type        = string
}

variable "email_service_lambda_function_runtime" {
  description = "The runtime environment for the email service Lambda function."
  type        = string
}

variable "email_service_lambda_function_filename" {
  description = "The filename of the deployment package for the email service Lambda function."
  type        = string
}

variable "email_service_lambda_function_memory_size" {
  description = "The amount of memory available to the email service Lambda function."
  type        = number
}

variable "email_service_lambda_function_timeout" {
  description = "The timeout duration for the email service Lambda function."
  type        = number
}

########################################################################
# EKS Cluster
########################################################################
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

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_gateway_protocol_type" {
  description = "The protocol type for the API Gateway (HTTP, WEBSOCKET)"
  type        = string
}

variable "api_gateway_lambda_permission_statement_id" {
  description = "The statement ID for the Lambda permission associated with the API Gateway"
  type        = string
}

variable "api_gateway_lambda_permission_action" {
  description = "The Lambda permission action for the API Gateway"
  type        = string
}

variable "api_gateway_lambda_permission_function_name" {
  description = "The Lambda function name for the API Gateway permission"
  type        = string
}

variable "api_gateway_lambda_permission_principal" {
  description = "The principal used for the Lambda permission"
  type        = string
}

variable "api_gateway_lambda_integration_integration_type" {
  description = "The integration type for Lambda integration (AWS_PROXY)"
  type        = string
}

variable "api_gateway_lambda_integration_integration_uri" {
  description = "The URI of the Lambda function to integrate with API Gateway"
  type        = string
}

variable "api_gateway_lambda_integration_payload_format_version" {
  description = "The payload format version for Lambda integration"
  type        = string
}

variable "api_gateway_video_processor_api_integration_type" {
  description = "The integration type for EKS integration (HTTP_PROXY)"
  type        = string
}

variable "api_gateway_video_processor_api_integration_method" {
  description = "The HTTP method for the EKS integration"
  type        = string
}

variable "api_gateway_video_processor_api_connection_type" {
  description = "The connection type for EKS integration (INTERNET)"
  type        = string
}

variable "api_gateway_video_processor_api_integration_uri" {
  description = "The URI of the EKS integration for API Gateway"
  type        = string
}

variable "api_gateway_auto_deploy" {
  description = "Whether to enable auto-deploy for the API Gateway"
  type        = bool
}
