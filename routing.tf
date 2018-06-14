resource "aws_route_table" "public" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${length(var.aws_availability_zones)}"

  tags {
    Name = "${var.vpc_name}-public-${count.index + 1}"
  }
}

resource "aws_route_table" "private" {
  vpc_id = "${aws_vpc.vpc.id}"
  count  = "${ var.create_private_subnet * length(var.aws_availability_zones) }"

  tags {
    Name = "${var.vpc_name}-private-${count.index + 1}"
  }
}

resource "aws_route" "public-internet" {
  depends_on = ["aws_route_table.public"]

  #  count = "${length(aws_route_table.public.*.id)}"	# Cannot use it due to bug in dependency graph
  count                  = "${length(var.aws_availability_zones)}"
  route_table_id         = "${element(aws_route_table.public.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.gw.id}"
}

resource "aws_route" "private-internet" {
  depends_on = ["aws_route_table.private"]

  #  count = "${length(aws_route_table.private.*.id)}"	# Cannot use it due to bug in dependency graph
  count                  = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
  route_table_id         = "${element(aws_route_table.private.*.id, count.index)}"
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = "${element(aws_nat_gateway.gw.*.id, count.index)}"
}

resource "aws_route_table_association" "public" {
  count          = "${length(var.aws_availability_zones)}"
  subnet_id      = "${element(aws_subnet.public.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.public.*.id, count.index)}"
}

resource "aws_route_table_association" "private" {
  count          = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
  subnet_id      = "${element(aws_subnet.private.*.id, count.index)}"
  route_table_id = "${element(aws_route_table.private.*.id, count.index)}"
}
