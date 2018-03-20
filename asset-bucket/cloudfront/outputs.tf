output "assets_cdn_hostname" {
  value = "${aws_cloudfront_distribution.cdn.domain_name}"
}

output "assets_cdn_zone_id" {
  value = "${aws_cloudfront_distribution.cdn.hosted_zone_id}"
}
