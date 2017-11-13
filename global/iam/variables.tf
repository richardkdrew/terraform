variable "bucket_deployer" {
	description = "The name of the user to create (as a deployment user for the bucket), e.g. bucket-deployer"
}

variable bucket_name {
	description = "The name of the S3 bucket to configure the deployemnt user for, e.g. your-bucket-name"
}

variable region {
	description = "e.g. eu-central-1"
}
