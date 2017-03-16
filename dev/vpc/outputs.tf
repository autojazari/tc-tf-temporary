output "private_subnet_ids" {
  value = [
    "${aws_subnet.private1.id}", 
    "${aws_subnet.private2.id}",
    "${aws_subnet.private3.id}"
  ]
}
output "sg_allow_https" {
  value = "${aws_security_group.allow_https.id}"
}