variable "aws_account_id" {
  description = "The AWS account ID to allow access in the SNS topic policy."
  type        = string
}

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

variable "aws_lambda_function_email_service_arn" {
  description = "The name arn of email service lambda function."
  type        = string
}
