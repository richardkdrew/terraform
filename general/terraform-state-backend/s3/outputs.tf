output "terraform_state_bucket_arn" {
  value = "${aws_s3_bucket.terraform_state_bucket.arn}"
}
