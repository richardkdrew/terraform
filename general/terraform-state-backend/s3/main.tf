################################################################################################################
## Configure the AWS provider for the specific region
################################################################################################################
provider "aws" {
  alias = "${var.region}"
  region = "${var.region}"
}


################################################################################################################
## Configure the bucket
################################################################################################################
resource "aws_s3_bucket" "terraform_state_bucket" {
  provider  = "aws.${var.region}"
  bucket    = "${var.bucket_name}"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.bucket_name}", "Environment", "${var.environment}", "Project", "${var.project}"))}"
}
