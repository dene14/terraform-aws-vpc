variable "vpc_cidr_block" {}

variable "vpc_name" {}

variable "aws_availability_zones" {
  type = "list"
}

variable "subnet_cidr_bits" {
  default = 24
}

variable "enable_dns_support" {
  default = true
}

variable "enable_dns_hostnames" {
  default = true
}

variable "enable_classiclink" {
  default = false
}

variable "instance_tenancy" {
  default = "default"
}

variable "create_private_subnet" {
  default = 1
}
