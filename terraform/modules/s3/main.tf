########################################################################
# Setup Bucket Region
########################################################################
terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  alias  = "us_east_2"
  region = "us-east-2"
}

########################################################################
# S3 Bucket: Video Files
########################################################################
resource "aws_s3_bucket" "aws_s3_bucket_video_files" {
  provider = aws.us_east_2
  bucket = var.bucket_name_video_files
  tags = var.bucket_tags_video_files
}

resource "aws_s3_bucket_versioning" "aws_s3_bucket_versioning_video_files" {
  provider = aws.us_east_2
  bucket = aws_s3_bucket.aws_s3_bucket_video_files.id

  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_s3_bucket_server_side_encryption_configuration_video_files" {
  provider = aws.us_east_2
  bucket = aws_s3_bucket.aws_s3_bucket_video_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "aws_s3_bucket_public_access_block_video_files" {
  provider = aws.us_east_2
  bucket                  = aws_s3_bucket.aws_s3_bucket_video_files.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

########################################################################
# S3 Bucket: Video Images Files
########################################################################
resource "aws_s3_bucket" "aws_s3_bucket_video_images_files" {
  provider = aws.us_east_2
  bucket = var.bucket_name_video_images_files
  tags = var.bucket_tags_video_images_files
}

resource "aws_s3_bucket_versioning" "aws_s3_bucket_versioning_video_images_files" {
  provider = aws.us_east_2
  bucket = aws_s3_bucket.aws_s3_bucket_video_images_files.id

  versioning_configuration {
    status = var.versioning_status
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "aws_s3_bucket_server_side_encryption_configuration_video_images_files" {
  provider = aws.us_east_2
  bucket = aws_s3_bucket.aws_s3_bucket_video_images_files.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = var.encryption_algorithm
    }
  }
}

resource "aws_s3_bucket_public_access_block" "aws_s3_bucket_public_access_block_video_images_files" {
  provider                = aws.us_east_2
  bucket                  = aws_s3_bucket.aws_s3_bucket_video_images_files.id
  block_public_acls       = var.block_public_acls
  block_public_policy     = var.block_public_policy
  ignore_public_acls      = var.ignore_public_acls
  restrict_public_buckets = var.restrict_public_buckets
}

########################################################################
# Outputs
########################################################################
output "s3_bucket_video_files_name" {
  value = aws_s3_bucket.aws_s3_bucket_video_files.bucket
}

output "s3_bucket_video_files_uri" {
  value = "s3://${aws_s3_bucket.aws_s3_bucket_video_files.bucket}"
}

output "s3_bucket_video_files_arn" {
  value = aws_s3_bucket.aws_s3_bucket_video_files.arn
}

output "s3_bucket_video_images_files_name" {
  value = aws_s3_bucket.aws_s3_bucket_video_images_files.bucket
}

output "s3_bucket_video_images_files_uri" {
  value = "s3://${aws_s3_bucket.aws_s3_bucket_video_images_files.bucket}"
}

output "s3_bucket_video_images_files_arn" {
  value = aws_s3_bucket.aws_s3_bucket_video_images_files.arn
}