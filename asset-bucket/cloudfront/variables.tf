variable acm_certificate_arn {}

variable domain {
  description = "The domain name for the website being hosted, e.g. example.com"
}

variable duplicate_content_penalty_secret {
  description = "Secret/password used to restrict access to S3 to CloudFront"
}

variable environment {
  default     = "default"
  description = "The label for the environment. Used for naming/tagging purposes"
}

variable hosted_zone_id {
  description = "The Hosted Zone ID of the Route53 domain"
}

variable project {
  default     = "noproject"
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
