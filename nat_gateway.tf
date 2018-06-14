# NAT Gateways
resource "aws_eip" "gw" {
  vpc   = true
  count = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
}

resource "aws_nat_gateway" "gw" {
  count         = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
  allocation_id = "${element(aws_eip.gw.*.id, count.index)}"
  subnet_id     = "${element(aws_subnet.public.*.id, count.index)}"
}
