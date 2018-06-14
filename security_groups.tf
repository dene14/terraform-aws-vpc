resource "aws_security_group" "private_nat" {
  count       = "${var.create_private_subnet}"
  name        = "${var.vpc_name}-nat-routers"
  description = "Full access for NAT addresses of private subnet in ${var.vpc_name} VPC"
  vpc_id      = "${aws_vpc.vpc.id}"

  tags {
    Name = "${var.vpc_name}-nat-routers"
  }
}

resource "aws_security_group_rule" "nat_routers" {
  count             = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
  type              = "ingress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  cidr_blocks       = ["${element(aws_eip.gw.*.public_ip, count.index)}/32"]
  security_group_id = "${aws_security_group.private_nat.id}"
}
