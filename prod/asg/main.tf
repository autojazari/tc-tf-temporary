# Auto Scaling Groups

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

resource "aws_placement_group" "nap_n" {
  name     = "nap-n-placement_group"
  strategy = "cluster"
}

resource "aws_launch_configuration" "nap_n" {
    name_prefix = "nap-n-"
    image_id = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "nap_n" {
  availability_zones        = ["us-east-1b", "us-east-1d", "us-east-1e"]
  name                      = "nap-n-autoscaling-group"
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
    value               = "nap-01"
    propagate_at_launch = true
  }
}

resource "aws_placement_group" "ldr_n" {
  name     = "tap-n-placement_group"
  strategy = "cluster"
}

resource "aws_launch_configuration" "ldr_n" {
    name_prefix = "ldr-n-"
    image_id = "${data.aws_ami.ubuntu.id}"
    instance_type = "t2.micro"

    lifecycle {
      create_before_destroy = true
    }
}

resource "aws_autoscaling_group" "ldr_n" {
  availability_zones        = ["us-east-1b", "us-east-1d", "us-east-1e"]
  name                      = "ldr-n-autoscaling-group"
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
    value               = "ldr-01"
    propagate_at_launch = true
  }
}