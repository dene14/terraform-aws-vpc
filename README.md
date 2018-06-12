# terraform-aws-vpc
Terraform module to create AWS VPC network layout with internal/external subnets.

Example below:
```
module "vpc" {
  source = "https://github.com/dene14/terraform-aws-vpc.git"
  vpc_name = "${var.environment}"
  vpc_cidr_block = "10.20.0.0/16"
  aws_availability_zones = ["us-east-1a","us-east-1b","us-east-1c"]
  subnet_cidr_bits = "20"
  enable_dns_support = true
  enable_dns_hostnames = true
  enable_classiclink = false   # "true" supported only for 10.1.0.0/16 VPC IP address block per AWS documentation
  create_private_subnet  = true
}
```
