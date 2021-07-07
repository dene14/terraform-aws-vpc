# NAT Gateways
resource "aws_eip" "gw" {
  vpc   = true
  count = length(var.aws_availability_zones)
  tags  = "${merge("${var.tags}", map("Name", "${var.vpc_name}-nat"))}"
}

resource "aws_nat_gateway" "gw" {
  count         = length(var.aws_availability_zones)
  allocation_id = "${element(aws_eip.gw.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
  tags          = "${merge("${var.tags}", map("Name", "${var.vpc_name}-nat"))}"
}
