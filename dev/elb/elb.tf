# Load States

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    bucket = "terraform.autojazari.mp.org"
    key = "dev/vpc/.tfstate"    
    region = "us-east-1"
  }
}

data "terraform_remote_state" "s3" {
  backend = "s3"
  config {
    bucket = "terraform.autojazari.mp.org"
    key = "dev/s3/.tfstate"    
    region = "us-east-1"
  }
}

# Application Load Balancers

resource "aws_alb" "teacher-elb" {
  name            = "teacher-elb"
  internal        = false
  security_groups = ["${data.terraform_remote_state.vpc.sg_allow_https}"]
  subnets         = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]

  enable_deletion_protection = true 

  access_logs {
    bucket = "${data.terraform_remote_state.s3.elb_access_logs_bucket}"
    prefix = "teacher-elb"
  }

  tags {
    Environment = "${var.region}"
  }
}

resource "aws_alb" "assessment-elb" {
  name            = "assessment-elb"
  internal        = false
  security_groups = ["${data.terraform_remote_state.vpc.sg_allow_https}"]
  subnets         = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${data.terraform_remote_state.s3.elb_access_logs_bucket}"
    prefix = "assessment-elb"
  }

  tags {
    Environment = "${var.region}"
  }
}

resource "aws_alb" "test-content-elb" {
  name            = "test-content-elb"
  internal        = false
  security_groups = ["${data.terraform_remote_state.vpc.sg_allow_https}"]
  subnets         = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${data.terraform_remote_state.s3.elb_access_logs_bucket}"
    prefix = "test-content-elb"
  }

  tags {
    Environment = "${var.region}"
  }
}

resource "aws_alb" "ldr-elb" {
  name            = "ldr-elb"
  internal        = false
  security_groups = ["${data.terraform_remote_state.vpc.sg_allow_https}"]
  subnets         = ["${data.terraform_remote_state.vpc.private_subnet_ids}"]

  enable_deletion_protection = true

  access_logs {
    bucket = "${data.terraform_remote_state.s3.elb_access_logs_bucket}"
    prefix = "ldr-elb"
  }

  tags {
    Environment = "${var.region}"
  }
}
