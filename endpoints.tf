resource "aws_vpc_endpoint" "private-s3" {
  vpc_id          = "${aws_vpc.vpc.id}"
  service_name    = "com.amazonaws.${data.aws_region.current.name}.s3"
  route_table_ids = ["${concat(aws_route_table.private.*.id, aws_route_table.public.*.id)}"]
  count           = "${var.create_private_subnet}"
}
