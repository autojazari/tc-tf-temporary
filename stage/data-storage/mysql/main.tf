# RDS Instances

resource "aws_db_subnet_group" "default" {
    name = "test-connect-db-subnetgroup"
    subnet_ids = ["${aws_route_table.private.*.id}"]
    tags {
        Name = "DB private subnets group"
    }
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t1.micro"
  name                 = "${var.tap}"
  username             = "${var.mysql_rds_username}"
  password             = "${var.mysql_rds_password}"
  db_subnet_group_name = "${aws_db_instance.default.name}"
  parameter_group_name = "default.mysql5.6"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t1.micro"
  name                 = "nap"
  username             = "${var.mysql_rds_username}"
  password             = "${var.mysql_rds_password}"
  db_subnet_group_name = "${aws_db_instance.default.name}"
  parameter_group_name = "default.mysql5.6"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t1.micro"
  name                 = "tc"
  username             = "${var.mysql_rds_username}"
  password             = "${var.mysql_rds_password}"
  db_subnet_group_name = "${aws_db_instance.default.name}"
  parameter_group_name = "default.mysql5.6"
}

resource "aws_db_instance" "default" {
  allocated_storage    = 10
  engine               = "mysql"
  engine_version       = "5.6.17"
  instance_class       = "db.t1.micro"
  name                 = "ldr"
  username             = "${var.mysql_rds_username}"
  password             = "${var.mysql_rds_password}"
  db_subnet_group_name = "${aws_db_instance.default.name}"
  parameter_group_name = "default.mysql5.6"
}