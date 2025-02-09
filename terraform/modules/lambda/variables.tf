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
