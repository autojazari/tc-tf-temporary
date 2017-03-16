# S3 buckets

resource "aws_s3_bucket" "elb_access_logs" {
    bucket = "${var.s3_elb_access_logs_bucket}"
    acl = "private"

    tags {
        Name = "ELB Access Logs"
        Environment = "Sandbox"
    }
}