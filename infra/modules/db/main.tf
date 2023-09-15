resource "aws_db_subnet_group" "this" {
  for_each = 

  name        = local.name
  name_prefix = local.name_prefix
  description = local.description
  subnet_ids  = var.subnet_ids

  tags = merge(
    var.tags,
    {
      "Name" = var.name
    },
  )
}

resource "aws_db_instance" "main" {
  allocated_storage   = var.allocated_stsorage
  db_name             = var.db_name
  engine              = var.db_engine
  engine_version      = var.engine_version
  instance_class      = var.db_instance_tier
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = var.skip_final_snapshot
  db_subnet_group_name = 

  tags = merge({
    Name = "${var.resource_name_prefix}-vpc1-db1"
  }, var.tags)
}