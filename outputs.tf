output "vpc.id" {
  value = "${aws_vpc.vpc.id}"
}

output "vpc.aws_availability_zones" {
  value = "${var.aws_availability_zones}"
}

output "subnets.private_ids" {
  value = ["${aws_subnet.private.*.id}"]
}

output "subnets.public_ids" {
  value = ["${aws_subnet.public.*.id}"]
}

output "route_tables.private" {
  value = ["${aws_route_table.private.*.id}"]
}

output "route_tables.public" {
  value = ["${aws_route_table.public.*.id}"]
}

output "subnets.private_cidr_blocks" {
  value = ["${aws_subnet.private.*.cidr_block}"]
}

output "subnets.public_cidr_blocks" {
  value = ["${aws_subnet.public.*.cidr_block}"]
}

output "subnets.private_nat_ips" {
  value = ["${aws_eip.gw.*.public_ip}"]
}

output "security_group.nat_routers" {
  value = "${aws_security_group.private_nat.id}"
}
