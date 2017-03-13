provider "aws" {
	access_key = "${var.aws_access_key}"
	secret_key = "${var.aws_secret_key}"
	region = "us-east-1"
}

# VPC
resource "aws_vpc" "default" {
	cidr_block = "172.16.0.0/12"
}

# Internet Gateway

resource "aws_internet_gateway" "default" {
	vpc_id = "${aws_vpc.default.id}"
}

# Public subnets

resource "aws_subnet" "us-east-1b-public" {
	vpc_id = "${aws_vpc.default.id}"

	cidr_block = "172.16.0.0/24"
	availability_zone = "us-east-1b"
}

# Routing table for public subnets

resource "aws_route_table" "us-east-1-public" {
	vpc_id = "${aws_vpc.default.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.default.id}"
	}
}

resource "aws_route_table_association" "us-east-1b-public" {
	subnet_id = "${aws_subnet.us-east-1b-public.id}"
	route_table_id = "${aws_route_table.us-east-1-public.id}"
}

# NAT Gateway

resource "aws_eip" "nat" {
	vpc = true
}

# EIP for NAT GTWY

resource "aws_nat_gateway" "gw" {
    allocation_id = "${aws_eip.nat.id}"
    subnet_id = "${aws_subnet.us-east-1b-public.id}"
}

# Private subsets

resource "aws_subnet" "us-east-1b-private" {
	vpc_id = "${aws_vpc.default.id}"

	cidr_block = "172.16.1.0/24"
	availability_zone = "us-east-1b"
}

resource "aws_subnet" "us-east-1d-private" {
	vpc_id = "${aws_vpc.default.id}"

	cidr_block = "172.16.3.0/24"
	availability_zone = "us-east-1d"
}

resource "aws_subnet" "us-east-1e-private" {
	vpc_id = "${aws_vpc.default.id}"

	cidr_block = "172.16.4.0/24"
	availability_zone = "us-east-1e"
}

# Routing table for private subnets

resource "aws_route_table" "us-east-1-private" {
	vpc_id = "${aws_vpc.default.id}"

	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${aws_nat_gateway.gw.id}"
	}
}

resource "aws_route_table_association" "us-east-1b-private" {
	subnet_id = "${aws_subnet.us-east-1b-private.id}"
	route_table_id = "${aws_route_table.us-east-1-private.id}"
}

resource "aws_route_table_association" "us-east-1d-private" {
	subnet_id = "${aws_subnet.us-east-1d-private.id}"
	route_table_id = "${aws_route_table.us-east-1-private.id}"
}

resource "aws_route_table_association" "us-east-1e-private" {
	subnet_id = "${aws_subnet.us-east-1e-private.id}"
	route_table_id = "${aws_route_table.us-east-1-private.id}"
}

resource "aws_placement_group" "tap_n" {
  name     = "tap-n-placement_group"
  strategy = "cluster"
}

resource "aws_launch_configuration" "tap_n" {
    name_prefix = "tap-n-"
    image_id = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "tap_n" {
  availability_zones        = ["us-east-1b", "us-east-1d", "us-east-1e"]
  name                      = "tap-n-autoscaling-group"
  max_size                  = 5
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 4
  force_delete              = true
  placement_group           = "${aws_placement_group.tap_n.id}"
  launch_configuration      = "${aws_launch_configuration.tap_n.name}"

  tag {
    key                 = "name"
    value               = "tap-01"
    propagate_at_launch = true
  }
}