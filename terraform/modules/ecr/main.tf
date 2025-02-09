resource "aws_ecr_repository" "ecr_repository_video_processor_api" {
  name = var.ecr_repository_video_processor_api_name
}

resource "aws_ecr_repository" "ecr_repository_video_processor_worker" {
  name = var.ecr_repository_video_processor_worker_name
}

########################################################################
# Outputs
########################################################################
output "ecr_repository_video_processor_api_uri" {
  value = aws_ecr_repository.ecr_repository_video_processor_api.repository_url
}

output "ecr_repository_video_processor_worker_uri" {
  value = aws_ecr_repository.ecr_repository_video_processor_worker.repository_url
}