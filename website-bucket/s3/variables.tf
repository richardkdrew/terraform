variable "bucket_name" {
	description = "The name of the S3 bucket to create, e.g. your-bucket-name"
}

variable duplicate_content_penalty_secret {
  description = "Secret/password used to restrict access to S3 to CloudFront"
}

variable environment {
  default = "default"
  description = "The label for the environment. Used for naming/tagging purposes"
}

variable project {
  default = "noproject"
  description = "The label for the project. Used for naming/tagging purposes"
}

variable region {
	description = "e.g. eu-central-1"
}

variable tags {
  default     = {}
  description = "Optional Tags"
  type        = "map"
}
