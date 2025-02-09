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

variable "cognito_user_pool_user_accounts_id" {
  description = "Cognito user pool id"
  type        = string
}

variable "cognito_user_pool_client_user_accounts_id" {
  description = "Cognito client id"
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

/* variable "api_gateway_orders_service_integration_type" {
  description = "The type of integration for the orders service (e.g., HTTP_PROXY, AWS_PROXY)"
  type        = string
}

variable "api_gateway_orders_service_integration_method" {
  description = "The HTTP method used for the orders service integration (e.g., GET, POST, ANY)"
  type        = string
}

variable "api_gateway_orders_service_connection_type" {
  description = "The type of connection for the orders service integration (e.g., INTERNET, VPC_LINK)"
  type        = string
}

variable "api_gateway_orders_service_integration_uri" {
  description = "The URI for the orders service integration"
  type        = string
}

variable "api_gateway_payments_service_integration_type" {
  description = "The type of integration for the payments service (e.g., HTTP_PROXY, AWS_PROXY)"
  type        = string
}

variable "api_gateway_payments_service_integration_method" {
  description = "The HTTP method used for the payments service integration (e.g., GET, POST, ANY)"
  type        = string
}

variable "api_gateway_payments_service_connection_type" {
  description = "The type of connection for the payments service integration (e.g., INTERNET, VPC_LINK)"
  type        = string
}

variable "api_gateway_payments_service_integration_uri" {
  description = "The URI for the payments service integration"
  type        = string
} */
