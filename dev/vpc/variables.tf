variable "region" {
  default = "us-east-1"
}
variable "vpc_public_subnet0" {
  type = "map"
}
variable "vpc_private_subnet1" {
  type = "map"
}
variable "vpc_private_subnet2" {
  type = "map"
}
variable "vpc_private_subnet3" {
  type = "map"
}
variable "vpc_cidr_block" {}
variable "vpc_public_subnet0_cidr_block" {}
variable "vpc_private_subnet1_cidr_block" {}
variable "vpc_private_subnet2_cidr_block" {}
variable "vpc_private_subnet3_cidr_block" {}
