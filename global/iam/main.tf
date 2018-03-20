################################################################################################################
## Configure the AWS provider for the specific region
################################################################################################################
provider "aws" {
  alias  = "${var.region}"
  region = "${var.region}"
}

################################################################################################################
## Configure access to the bucket
################################################################################################################
data "template_file" "deployer_role_policy" {
  template = "${file("${path.module}/deployer-role-policy.json")}"

  vars {
    bucket = "${var.bucket_name}"
  }
}

resource "aws_iam_policy" "deployer_policy" {
  provider    = "aws.${var.region}"
  name        = "${var.bucket_name}.deployer-policy"
  path        = "/"
  description = "Policy allowing the publish of new version(s) of the contents to the S3 bucket"
  policy      = "${data.template_file.deployer_role_policy.rendered}"
}

resource "aws_iam_policy_attachment" "deployment_user_attach_deployer_policy" {
  provider   = "aws.${var.region}"
  name       = "${var.bucket_name}-deployer-policy-attachment"
  users      = ["${var.bucket_deployer}"]
  policy_arn = "${aws_iam_policy.deployer_policy.arn}"
}
