# Declare the data source for AZ
data "aws_availability_zones" "available" {}
# WE CANNOT USE DATA SOURCE NOW SINCE IT COULDN'T BE REFERENCED AS "COUNT" FOR INTERPOLATION

# VPC declaration
resource "aws_vpc" "vpc" {
    cidr_block = "${var.vpc_cidr_block}"
    enable_dns_support = "${var.enable_dns_support}"
    enable_dns_hostnames = "${var.enable_dns_hostnames}"
    enable_classiclink = "${var.enable_classiclink}"

    tags {
        Name = "${var.vpc_name}"
    }
}
