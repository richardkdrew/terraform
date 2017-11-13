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
resource "aws_s3_bucket" "terraform_state_storage_bucket" {
  provider  = "aws.${var.region}"
  bucket    = "${var.bucket_name}-terraform-remote-state-storage"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.bucket_name}", "Project", "${var.project}"))}"
}
