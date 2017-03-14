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
