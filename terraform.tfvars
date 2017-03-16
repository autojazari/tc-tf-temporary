vpc_public_subnet0 = {
	us-east-1 = "us-east-1b"
    us-west-2 = "us-west-2c"
}
vpc_private_subnet1 = {
	us-east-1 = "us-east-1b"
    us-west-2 = "us-west-2a"
}
vpc_private_subnet2 = {
	us-east-1 = "us-east-1d"
    us-west-2 = "us-west-2e"
}
vpc_private_subnet3 = {
	us-east-1 = "us-east-1e"
    us-west-2 = "us-west-2c"
}
aws_ubuntu_ami = {
	us-east-1 = "ami-b374d5a5"
    us-west-2 = "ami-59653c39"
}
asg_availability_zones = {
	us-east-1 = ["us-east-1b", "us-east-1d", "us-east-1e"]
}
vpc_cidr_block = "172.16.0.0/16"
vpc_public_subnet0_cidr_block = "172.16.0.0/24"
vpc_private_subnet1_cidr_block = "172.16.1.0/24"
vpc_private_subnet2_cidr_block = "172.16.2.0/24"
vpc_private_subnet3_cidr_block = "172.16.3.0/24"