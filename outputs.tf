output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "vpc_aws_availability_zones" {
  value = var.aws_availability_zones
}

output "subnets_private_ids" {
  # Ugly workaround for https://github.com/hashicorp/terraform/issues/12453
  value = split(",", length(aws_route_table.private) > 0 ? join(",", aws_subnet.private.*.id) : "")
}

output "subnets_public_ids" {
  value = aws_subnet.public.*.id
}

output "route_tables_private" {
  value = split(",", length(aws_route_table.private) > 0 ? join(",", aws_route_table.private.*.id) : "")
}

output "route_tables_public" {
  value = aws_route_table.public.*.id
}

output "subnets_private_cidr_blocks" {
  value = split(",", length(aws_subnet.private) > 0 ? join(",", aws_subnet.private.*.cidr_block) : "")
}

output "subnets_public_cidr_blocks" {
  value = aws_subnet.public.*.cidr_block
}

output "subnets_private_nat_ips" {
  value = aws_eip.gw.*.public_ip
}

output "security_group_nat_routers" {
  value = split(",", length(aws_security_group.private_nat) > 0 ? join(",", aws_security_group.private_nat.*.id) : "")
}
