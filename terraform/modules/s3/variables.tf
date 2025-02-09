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
