variable "region" {
  default = "us-east-1"
}
variable "aws_ubuntu_ami" {
  type = "map"
}
variable "asg_availability_zones" {
	type = "map"
}