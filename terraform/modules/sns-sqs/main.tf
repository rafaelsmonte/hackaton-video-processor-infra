#============================================================================
# Authors: Thiago, Vitor, Rafael
# Description: Creates SNS and SQS infrastructure
#============================================================================

########################################################################
# SQS: Video Processor API
########################################################################
resource "aws_sqs_queue" "aws_sqs_queue_video_processor_api_dlq" {
  name                          = var.video_processor_api_queue_dlq_name
  fifo_queue                    = false
  content_based_deduplication   = false
  delay_seconds                 = var.video_processor_api_queue_dlq_delay_seconds
  max_message_size              = var.video_processor_api_dlq_max_message_size
  message_retention_seconds     = var.video_processor_api_dlq_message_retention_seconds
  receive_wait_time_seconds     = var.video_processor_api_dlq_receive_wait_time_seconds
  visibility_timeout_seconds    = var.video_processor_api_dlq_visibility_timeout_seconds
}

resource "aws_sqs_queue" "aws_sqs_queue_video_processor_api" {
  name                          = var.video_processor_api_queue_name
  fifo_queue                    = false
  content_based_deduplication   = false
  delay_seconds                 = var.video_processor_api_queue_delay_seconds
  max_message_size              = var.video_processor_api_queue_max_message_size
  message_retention_seconds     = var.video_processor_api_queue_message_retention_seconds
  receive_wait_time_seconds     = var.video_processor_api_queue_receive_wait_time_seconds
  visibility_timeout_seconds    = var.video_processor_api_queue_visibility_timeout_seconds
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.aws_sqs_queue_video_processor_api_dlq.arn
    maxReceiveCount     = var.video_processor_api_redrive_policy_max_receive_count
  })
}

########################################################################
# SQS: Video Processor Worker
########################################################################
resource "aws_sqs_queue" "aws_sqs_queue_video_processor_worker_dlq" {
  name                          = var.video_processor_worker_queue_dlq_name
  fifo_queue                    = false
  content_based_deduplication   = false
  delay_seconds                 = var.video_processor_worker_queue_dlq_delay_seconds
  max_message_size              = var.video_processor_worker_dlq_max_message_size
  message_retention_seconds     = var.video_processor_worker_dlq_message_retention_seconds
  receive_wait_time_seconds     = var.video_processor_worker_dlq_receive_wait_time_seconds
  visibility_timeout_seconds    = var.video_processor_worker_dlq_visibility_timeout_seconds
}

resource "aws_sqs_queue" "aws_sqs_queue_video_processor_worker" {
  name                          = var.video_processor_worker_queue_name
  fifo_queue                    = false
  content_based_deduplication   = false
  delay_seconds                 = var.video_processor_worker_queue_delay_seconds
  max_message_size              = var.video_processor_worker_queue_max_message_size
  message_retention_seconds     = var.video_processor_worker_queue_message_retention_seconds
  receive_wait_time_seconds     = var.video_processor_worker_queue_receive_wait_time_seconds
  visibility_timeout_seconds    = var.video_processor_worker_queue_visibility_timeout_seconds
  
  redrive_policy = jsonencode({
    deadLetterTargetArn = aws_sqs_queue.aws_sqs_queue_video_processor_worker_dlq.arn
    maxReceiveCount     = var.video_processor_worker_redrive_policy_max_receive_count
  })
}

########################################################################
# SNS: Video Processor API
########################################################################
resource "aws_sns_topic" "aws_sns_topic_video_processor_api" {
  name                        = var.video_processor_api_topic_name
  fifo_topic                  = false
  content_based_deduplication = false

  tags = {
    Name = var.video_processor_api_topic_name
  }
}

resource "aws_sns_topic_policy" "aws_sns_topic_policy_video_processor_api" {
  arn = aws_sns_topic.aws_sns_topic_video_processor_api.arn

  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource = aws_sns_topic.aws_sns_topic_video_processor_api.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = var.aws_account_id
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "aws_sns_topic_subscription_video_processor_worker" {
  topic_arn = aws_sns_topic.aws_sns_topic_video_processor_api.arn
  protocol  = "sqs"
  endpoint  = resource.aws_sqs_queue.aws_sqs_queue_video_processor_worker.arn
  filter_policy_scope = "MessageBody"
  raw_message_delivery = true

  filter_policy = jsonencode({
    target = ["VIDEO_IMAGE_PROCESSOR_SERVICE"]
  })
}

resource "aws_sqs_queue_policy" "aws_sqs_queue_policy_video_processor_api_topic_on_video_processor_worker_queue" {
  queue_url = aws_sqs_queue.aws_sqs_queue_video_processor_worker.url
  policy    = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.aws_sqs_queue_video_processor_worker.arn
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.aws_sns_topic_video_processor_api.arn
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "aws_sns_topic_subscription_function_email_service" {
  topic_arn = aws_sns_topic.aws_sns_topic_video_processor_api.arn
  protocol  = "lambda"
  endpoint  = var.aws_lambda_function_email_service_arn
  filter_policy_scope = "MessageBody"

  filter_policy = jsonencode({
    target = ["EMAIL_SERVICE"]
  })
}

########################################################################
# SNS: Video Processor Worker
########################################################################
resource "aws_sns_topic" "aws_sns_topic_video_processor_worker" {
  name                        = var.video_processor_worker_topic_name
  fifo_topic                  = false
  content_based_deduplication = false

  tags = {
    Name = var.video_processor_worker_topic_name
  }
}

resource "aws_sns_topic_policy" "aws_sns_topic_policy_video_processor_worker" {
  arn = aws_sns_topic.aws_sns_topic_video_processor_worker.arn

  policy = jsonencode({
    Version = "2008-10-17",
    Id      = "__default_policy_ID",
    Statement = [
      {
        Sid       = "__default_statement_ID",
        Effect    = "Allow",
        Principal = {
          AWS = "*"
        },
        Action = [
          "SNS:Publish",
          "SNS:RemovePermission",
          "SNS:SetTopicAttributes",
          "SNS:DeleteTopic",
          "SNS:ListSubscriptionsByTopic",
          "SNS:GetTopicAttributes",
          "SNS:AddPermission",
          "SNS:Subscribe"
        ],
        Resource = aws_sns_topic.aws_sns_topic_video_processor_worker.arn,
        Condition = {
          StringEquals = {
            "AWS:SourceOwner" = var.aws_account_id
          }
        }
      }
    ]
  })
}

resource "aws_sns_topic_subscription" "aws_sns_topic_subscription_video_processor_api" {
  topic_arn = aws_sns_topic.aws_sns_topic_video_processor_worker.arn
  protocol  = "sqs"
  endpoint  = resource.aws_sqs_queue.aws_sqs_queue_video_processor_api.arn
  filter_policy_scope = "MessageBody"
  raw_message_delivery = true

  filter_policy = jsonencode({
    target = ["VIDEO_API_SERVICE"]
  })
}

resource "aws_sqs_queue_policy" "aws_sqs_queue_policy_video_processor_worker_topic_on_video_processor_api_queue" {
  queue_url = aws_sqs_queue.aws_sqs_queue_video_processor_api.url
  policy    = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Action    = "SQS:SendMessage"
        Resource  = aws_sqs_queue.aws_sqs_queue_video_processor_api.arn
        Principal = {
          Service = "sns.amazonaws.com"
        }
        Condition = {
          ArnEquals = {
            "aws:SourceArn" = aws_sns_topic.aws_sns_topic_video_processor_worker.arn
          }
        }
      }
    ]
  })
}

########################################################################
# Outputs
########################################################################
output "aws_sqs_queue_video_processor_api_dlq_name" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_api_dlq.name
}

output "aws_sqs_queue_video_processor_api_dlq_arn" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_api_dlq.arn
}

output "aws_sqs_queue_video_processor_api_name" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_api.name
}

output "aws_sqs_queue_video_processor_api_arn" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_api.arn
}

output "aws_sqs_queue_video_processor_worker_dlq_name" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_worker_dlq.name
}

output "aws_sqs_queue_video_processor_worker_dlq_arn" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_worker_dlq.arn
}

output "aws_sqs_queue_video_processor_worker_name" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_worker.name
}

output "aws_sqs_queue_video_processor_worker_arn" {
  value = aws_sqs_queue.aws_sqs_queue_video_processor_worker.arn
}

output "aws_sns_topic_video_processor_api_name" {
  value = aws_sns_topic.aws_sns_topic_video_processor_api.name
}

output "aws_sns_topic_video_processor_api_arn" {
  value = aws_sns_topic.aws_sns_topic_video_processor_api.arn
}

output "aws_sns_topic_video_processor_worker_name" {
  value = aws_sns_topic.aws_sns_topic_video_processor_worker.name
}

output "aws_sns_topic_video_processor_worker_arn" {
  value = aws_sns_topic.aws_sns_topic_video_processor_worker.arn
}