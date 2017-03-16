# VPC

resource "aws_vpc" "stage" {
	cidr_block = "${var.vpc_cidr_block}"
}

# Internet Gateway

resource "aws_internet_gateway" "stage" {
	vpc_id = "${aws_vpc.stage.id}"
}

# Public subnets

resource "aws_subnet" "public0" {
	vpc_id = "${aws_vpc.stage.id}"
	cidr_block = "${var.vpc_public_subnet0_cidr_block}"
	availability_zone = "${lookup(var.vpc_public_subnet0, var.region)}"
}

# Routing table for public subnets

resource "aws_route_table" "public0" {
	vpc_id = "${aws_vpc.stage.id}"

	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.stage.id}"
	}
}

resource "aws_route_table_association" "us-east-1b-public" {
	subnet_id = "${aws_subnet.public0.id}"
	route_table_id = "${aws_route_table.public0.id}"
}

# NAT Gateway

resource "aws_eip" "stage" {
	vpc = true
}

# EIP for NAT GTWY

resource "aws_nat_gateway" "stage" {
    allocation_id = "${aws_eip.stage.id}"
    subnet_id = "${aws_subnet.public0.id}"
}

# Private subsets

resource "aws_subnet" "private1" {
	vpc_id = "${aws_vpc.stage.id}"

	cidr_block = "${var.vpc_private_subnet1_cidr_block}"
	availability_zone = "${lookup(var.vpc_private_subnet1, var.region)}"
}

resource "aws_subnet" "private2" {
	vpc_id = "${aws_vpc.stage.id}"

	cidr_block = "${var.vpc_private_subnet2_cidr_block}"
	availability_zone = "${lookup(var.vpc_private_subnet2, var.region)}"
}

resource "aws_subnet" "private3" {
	vpc_id = "${aws_vpc.stage.id}"

	cidr_block = "${var.vpc_private_subnet3_cidr_block}"
	availability_zone = "${lookup(var.vpc_private_subnet3, var.region)}"
}

# Routing table for private subnets

resource "aws_route_table" "private" {
	vpc_id = "${aws_vpc.stage.id}"

	route {
		cidr_block = "0.0.0.0/0"
		nat_gateway_id = "${aws_nat_gateway.stage.id}"
	}
}

resource "aws_route_table_association" "private1" {
	subnet_id = "${aws_subnet.private1.id}"
	route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private2" {
	subnet_id = "${aws_subnet.private1.id}"
	route_table_id = "${aws_route_table.private.id}"
}

resource "aws_route_table_association" "private3" {
	subnet_id = "${aws_subnet.private3.id}"
	route_table_id = "${aws_route_table.private.id}"
}

# Security Groups

resource "aws_security_group" "allow_https" {
  name = "allow_https"
  description = "Allow inbound https traffic"

  ingress {
      from_port = 443
      to_port = 443
      protocol = "https"
      cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "allow_https"
  }
}
