########################################################################
# AWS Account
########################################################################
aws_vpc_id = "vpc-935824e9"
aws_account_id = "839260668425"

########################################################################
# ECR Repositories
########################################################################
ecr_repository_video_processor_api_name = "hackaton/video_processor_api"
ecr_repository_video_processor_worker_name = "hackaton/video_processor_worker"

########################################################################
# Cognito Database
########################################################################
cognito_database_name = "user-accounts-pool"
cognito_database_password_policy_minimum_length = 6
cognito_database_password_policy_require_uppercase = false
cognito_database_password_policy_require_lowercase = false
cognito_database_password_policy_require_numbers = false
cognito_database_password_policy_require_symbols =false
cognito_database_password_policy_temporary_password_validity_days = 7
cognito_database_auto_verified_attributes = []
cognito_database_account_recovery_setting_recovery_mechanism_name = "verified_email"
cognito_database_account_recovery_setting_recovery_mechanism_priority = 1
cognito_database_admin_create_user_config_allow_admin_create_user_only = false
cognito_database_email_configuration_email_sending_account = "COGNITO_DEFAULT"
cognito_database_user_pool_name = "user-accounts-app"
cognito_database_user_pool_generate_secret = false
cognito_database_user_pool_explicit_auth_flows = ["ALLOW_USER_SRP_AUTH","ALLOW_REFRESH_TOKEN_AUTH","ALLOW_USER_PASSWORD_AUTH"]
cognito_database_user_pool_refresh_token_validity = 30

########################################################################
# S3
########################################################################
bucket_name_video_files = "hackaton-7soat-video-files-storage"
bucket_tags_video_files = {
  Name = "hackaton-7soat-video-files-storage"
}
bucket_name_video_images_files = "hackaton-7soat-video-images-files-storage"
bucket_tags_video_images_files = {
  Name = "hackaton-7soat-video-images-files-storage"
}
versioning_status = "Suspended"
encryption_algorithm = "AES256"
block_public_acls = true
block_public_policy = true
ignore_public_acls = true
restrict_public_buckets = true

########################################################################
# SQS and SNS
########################################################################
video_processor_api_queue_dlq_name                       = "video-processor-api-dlq"
video_processor_api_queue_dlq_delay_seconds              = 10
video_processor_api_dlq_max_message_size                 = 262144
video_processor_api_dlq_message_retention_seconds        = 1209600
video_processor_api_dlq_receive_wait_time_seconds        = 10
video_processor_api_dlq_visibility_timeout_seconds       = 30

video_processor_api_queue_name                           = "video-processor-api-queue"
video_processor_api_queue_delay_seconds                  = 5
video_processor_api_queue_max_message_size               = 262144
video_processor_api_queue_message_retention_seconds      = 345600
video_processor_api_queue_receive_wait_time_seconds      = 10
video_processor_api_queue_visibility_timeout_seconds     = 30

video_processor_api_redrive_policy_max_receive_count     = 5

video_processor_worker_queue_dlq_name                       = "video-processor-worker-dlq"
video_processor_worker_queue_dlq_delay_seconds              = 10
video_processor_worker_dlq_max_message_size                 = 262144
video_processor_worker_dlq_message_retention_seconds        = 1209600
video_processor_worker_dlq_receive_wait_time_seconds        = 10
video_processor_worker_dlq_visibility_timeout_seconds       = 30

video_processor_worker_queue_name                           = "video-processor-worker-queue"
video_processor_worker_queue_delay_seconds                  = 5
video_processor_worker_queue_max_message_size               = 262144
video_processor_worker_queue_message_retention_seconds      = 345600
video_processor_worker_queue_receive_wait_time_seconds      = 10
video_processor_worker_queue_visibility_timeout_seconds     = 30

video_processor_worker_redrive_policy_max_receive_count     = 5

video_processor_api_topic_name                              = "video_processor_api_topic"
video_processor_worker_topic_name                           = "video_processor_worker_topic"

########################################################################
# Lambda Function
########################################################################
aws_secrets_name = "7Soat"
lambda_role_name = "lambda-exec-7soat-role"
lambda_execution_policy_name = "tech_challenge_7soat_lambda_execution_policy"
user_accounts_lambda_function_name = "user-accounts-service"
user_accounts_lambda_function_handler = "index.handler"
user_accounts_lambda_function_runtime = "nodejs20.x"
user_accounts_lambda_function_filename = "/home/thiago/Documents/studies/hackaton-video-processor-infra/terraform/modules/lambda/function.zip"
user_accounts_lambda_function_memory_size = 128
user_accounts_lambda_function_timeout = 15
email_service_lambda_function_name = "email-service"
email_service_lambda_function_handler = "index.handler"
email_service_lambda_function_runtime = "nodejs20.x"
email_service_lambda_function_filename = "/home/thiago/Documents/studies/hackaton-video-processor-infra/terraform/modules/lambda/function.zip"
email_service_lambda_function_memory_size = 128
email_service_lambda_function_timeout = 15

########################################################################
# EKS
########################################################################
eks_cluster_security_group_name = "eks-cluster-video-processor-sg"
eks_cluster_security_group_description = "Security group for 7soat hackaton eks cluster"
eks_cluster_name         = "video-processor-cluster"
eks_cluster_role_arn     = "arn:aws:iam::839260668425:role/AWS_EKS_ROLE"
eks_subnet_ids           = ["subnet-0d501603dbb6981a0","subnet-0628055b427ab2fe6"]
eks_node_group_name         = "tech-challenge-7soat-node-group"
eks_node_group_role         = "arn:aws:iam::839260668425:role/AWS_EKS_NODE_GROUP_ROLE"
eks_node_group_subnets      = ["subnet-0d501603dbb6981a0","subnet-0628055b427ab2fe6"]
eks_node_group_scaling_config = {
  desired_size = 2
  max_size     = 4
  min_size     = 2
}
eks_node_group_ami_type     = "AL2_x86_64"
eks_node_group_instance_types = ["t3.medium"]
eks_node_group_capacity_type = "SPOT"
eks_node_group_disk_size    = 20
eks_node_group_access_key   = "eks-cluster-video-processor-key"

########################################################################
# API Gateway
########################################################################
api_gateway_name = "hackaton-api-gateway"
api_gateway_protocol_type = "HTTP"
api_gateway_lambda_permission_statement_id = "AllowExecutionFromAPIGateway"
api_gateway_lambda_permission_action = "lambda:InvokeFunction"
api_gateway_lambda_permission_function_name = "user-accounts-service"
api_gateway_lambda_permission_principal = "apigateway.amazonaws.com"
api_gateway_lambda_integration_integration_type = "AWS_PROXY"
api_gateway_lambda_integration_integration_uri = "arn:aws:lambda:us-east-1:839260668425:function:user-accounts-service"
api_gateway_lambda_integration_payload_format_version = "2.0"
api_gateway_video_processor_api_integration_type = "HTTP_PROXY"
api_gateway_video_processor_api_integration_method = "ANY"
api_gateway_video_processor_api_connection_type = "INTERNET"
api_gateway_video_processor_api_integration_uri = "http://ab302b34941be4a0bb617babafed09de-48918628.us-east-1.elb.amazonaws.com/{proxy}"

api_gateway_auto_deploy = true