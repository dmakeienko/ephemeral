resource "aws_subnet" "main" {
  for_each = var.subnets

  vpc_id            = var.vpc_id
  cidr_block        = each.value.cidr_block
  availability_zone = each.value.availability_zone

  map_public_ip_on_launch = each.value.map_public_ip_on_launch

  tags = merge({
    Name = "${var.resource_name_prefix}-sn-${each.key}"
  }, var.tags)
}

resource "aws_route_table" "main" {
 for_each = var.subnets

  vpc_id           = var.vpc_id

 tags = merge({
    Name = "${var.resource_name_prefix}-sn-${each.key}-rt"
  }, var.tags)
}

resource "aws_route_table_association" "default" {
  for_each = var.subnets

  subnet_id      = aws_subnet.main[each.key].id
  route_table_id = aws_route_table.main[each.key].id
}