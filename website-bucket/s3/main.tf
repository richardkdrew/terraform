################################################################################################################
## Configure the AWS provider for the specific region
################################################################################################################
provider "aws" {
  alias = "${var.region}"
  region = "${var.region}"
}


################################################################################################################
## Configure the bucket and static website hosting
################################################################################################################
data "template_file" "website_bucket_policy" {
  template = "${file("${path.module}/website-bucket-policy.json")}"

  vars {
    bucket = "${var.bucket_name}"
    secret = "${var.duplicate_content_penalty_secret}"
  }
}

resource "aws_s3_bucket" "website_bucket" {
  provider  = "aws.${var.region}"
  bucket    = "${var.bucket_name}"
  policy    = "${data.template_file.website_bucket_policy.rendered}"

  website {
    index_document = "index.html"
  }

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.bucket_name}", "Environment", "${var.environment}", "Project", "${var.project}"))}"
}
