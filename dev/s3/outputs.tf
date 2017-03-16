output "elb_access_logs_bucket" {
  value = "${aws_s3_bucket.elb_access_logs.bucket}"
}