# S3 buckets

resource "aws_s3_bucket" "elb_access_logs" {
    bucket = "elb-access-logs.sandbox.measuredprogress.org"
    acl = "private"

    tags {
        Name = "ELB Access Logs"
        Environment = "Sandbox"
    }
}