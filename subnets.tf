resource "aws_subnet" "private" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    count                   = "${ var.create_private_subnet * length(var.aws_availability_zones) }"
    availability_zone       = "${element(var.aws_availability_zones, count.index)}"
    cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block,
                                      var.subnet_cidr_bits - element(split("/",aws_vpc.vpc.cidr_block), 1),
                                      count.index)}"
    map_public_ip_on_launch = false

    tags {
        "Name" = "${var.vpc_name}-private-${count.index + 1}"
    }
}

resource "aws_subnet" "public" {
    vpc_id                  = "${aws_vpc.vpc.id}"
    count                   = "${length(var.aws_availability_zones)}"
    availability_zone       = "${element(var.aws_availability_zones, count.index)}"
    cidr_block              = "${cidrsubnet(aws_vpc.vpc.cidr_block,
                                      var.subnet_cidr_bits - element(split("/",aws_vpc.vpc.cidr_block), 1),
                                      count.index + length(var.aws_availability_zones))}"
    map_public_ip_on_launch = true

    tags {
        "Name" = "${var.vpc_name}-public-${count.index + 1}"
    }
}