################################################################################################################
## Configure the AWS provider for the specific region
################################################################################################################
provider "aws" {
  alias = "${var.region}"
  region = "${var.region}"
}


################################################################################################################
## Create a Route53 dns entry
################################################################################################################
resource "aws_route53_record" "dns" {
  provider = "aws.${var.region}"
  name = "${var.entry_name}"
  type = "A"
  zone_id = "${var.hosted_zone_id}"

  alias {
      name = "${var.cdn_domain_name}"
      zone_id = "${var.cdn_hosted_zone_id}"
      evaluate_target_health = false
  }
}
