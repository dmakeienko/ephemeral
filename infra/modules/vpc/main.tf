resource "aws_vpc" "main" {
  cidr_block       = var.cidr_block
  instance_tenancy = var.instance_tenancy
 enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  tags = merge({
    Name = "${var.resource_name_prefix}-vpc1"
  }, var.tags)
}

resource "aws_default_route_table" "main" {
  default_route_table_id = aws_vpc.main.default_route_table_id
  tags     = merge({
    Name = "${var.resource_name_prefix}-vpc1-default-rt"
  }, var.tags)
}

resource "aws_vpc_dhcp_options" "main" {

  domain_name = var.domain_name
  domain_name_servers = var.domain_name_servers

  tags     = merge({
    Name = "${var.resource_name_prefix}-vpc1-dhcp-options"
  }, var.tags)
}

resource "aws_vpc_dhcp_options_association" "main" {
  vpc_id          = aws_vpc.main.id
  dhcp_options_id = aws_vpc_dhcp_options.main.id
}

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
  tags = merge({
    Name = "${var.resource_name_prefix}-vpc1-igw1"
  }, var.tags)
}