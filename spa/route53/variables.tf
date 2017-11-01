variable cdn_domain_name {
  description = "The domain name for the cdn the dns entry is for , e.g. blahblah.cloudfront.net"
}

variable cdn_hosted_zone_id {
  description = "The Hosted Zone ID of the CloudFront distribution"
}

variable entry_name {
  description = "The entry name for the website being hosted, e.g. example.com"
}

variable hosted_zone_id {
  description = "The Hosted Zone ID of the Route53 domain"
}

variable region {
	description = "e.g. eu-central-1"
}
