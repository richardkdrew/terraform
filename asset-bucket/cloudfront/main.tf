################################################################################################################
## Configure the AWS provider for the specific region
################################################################################################################
provider "aws" {
  alias  = "${var.region}"
  region = "${var.region}"
}

################################################################################################################
## Create a Cloudfront distribution for the static website
################################################################################################################
resource "aws_cloudfront_distribution" "cdn" {
  provider     = "aws.${var.region}"
  enabled      = true
  price_class  = "PriceClass_All"
  http_version = "http1.1"

  origin {
    origin_id   = "origin-bucket-${var.domain}"
    domain_name = "${var.domain}.s3-website-${var.region}.amazonaws.com"

    custom_origin_config {
      http_port              = "80"
      https_port             = "443"
      origin_protocol_policy = "http-only"
      origin_ssl_protocols   = ["TLSv1.2"]
    }

    custom_header {
      name  = "User-Agent"
      value = "${var.duplicate_content_penalty_secret}"
    }
  }

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # Forward (to origin) settings
    forwarded_values {
      query_string = true

      cookies {
        forward = "none"
      }
    }

    min_ttl     = "0"
    default_ttl = "300"  //3600
    max_ttl     = "1200" //86400

    target_origin_id = "origin-bucket-${var.domain}"

    // This redirects any HTTP request to HTTPS. Security first!
    viewer_protocol_policy = "redirect-to-https"
    compress               = true
  }

  # Restrictions for who is able to access this content
  restrictions {
    geo_restriction {
      # type of restriction, blacklist, whitelist or none
      restriction_type = "none"
    }
  }

  # SSL certificate for the service.
  viewer_certificate {
    acm_certificate_arn      = "${var.acm_certificate_arn}"
    ssl_support_method       = "sni-only"
    minimum_protocol_version = "TLSv1.2_2018"
  }

  aliases = "${var.aliases}"

  tags = "${merge("${var.tags}",map("Name", "${var.project}-${var.domain}", "Environment", "${var.environment}", "Project", "${var.project}"))}"
}
