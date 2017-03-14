# Application Load Balancers

resource "aws_alb" "teacher-elb" {
  name            = "teacher-elb"
  internal        = false
  security_groups = ["${aws_security_group.allow_https.id}"]
  subnets         = ["${aws_route_table.private.*.id}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${aws_s3_bucket.elb_access_logs.bucket}"
    prefix = "teacher-elb"
  }

  tags {
    Environment = "sandbox"
  }
}

resource "aws_alb" "assessment-elb" {
  name            = "assessment-elb"
  internal        = false
  security_groups = ["${aws_security_group.alb_sg.id}"]
  subnets         = ["${aws_route_table.private.*.id}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${aws_s3_bucket.elb_access_logs.bucket}"
    prefix = "assessment-elb"
  }

  tags {
    Environment = "sandbox"
  }
}

resource "aws_alb" "test-content-elb" {
  name            = "test-content-elb"
  internal        = false
  security_groups = ["${aws_security_group.alb_sg.id}"]
  subnets         = ["${aws_route_table.private.*.id}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${aws_s3_bucket.elb_access_logs.bucket}"
    prefix = "test-content-elb"
  }

  tags {
    Environment = "sandbox"
  }
}

resource "aws_alb" "ldr-elb" {
  name            = "ldr-elb"
  internal        = false
  security_groups = ["${aws_security_group.alb_sg.id}"]
  subnets         = ["${aws_route_table.private.*.id}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${aws_s3_bucket.elb_access_logs.bucket}"
    prefix = "ldr-elb"
  }

  tags {
    Environment = "sandbox"
  }
}
