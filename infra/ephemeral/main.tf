module "vpc" {
  source     = "../modules/vpc"
  cidr_block = var.vpc_cidr_block

  resource_name_prefix = local.resource_name_prefix
  tags                 = local.tags
}

##Subnets for RDS instance
module "rds_subnets" {
  source = "../modules/subnet"
  vpc_id = module.vpc.vpc_id

  subnets = {
    "rds1" = {
      cidr_block              = "10.0.1.0/24"
      availability_zone       = "${var.aws_region}a"
      map_public_ip_on_launch = true
    }
    "rds2" = {
      cidr_block              = "10.0.2.0/24"
      availability_zone       = "${var.aws_region}b"
      map_public_ip_on_launch = true
    }
  }

  resource_name_prefix = local.resource_name_prefix
  tags                 = local.tags
}

module "postgres" {
  source               = "../modules/db"
  db_engine            = "postgres"
  engine_version       = "15.4"
  db_password          = var.db_password
  subnet_ids           = values(module.rds_subnets.subnet_id)
  resource_name_prefix = local.resource_name_prefix
  allowed_network_cidr = var.allowed_network_cidr
  vpc_id = module.vpc.vpc_id
  
  tags = local.tags
}