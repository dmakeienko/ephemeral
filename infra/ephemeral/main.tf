module "vpc" {
  source = "../modules/vpc"
  cidr_block = "10.0.0.0/16"

  resource_name_prefix = local.resource_name_prefix 
  tags = local.tags
}

module "public_subnet" {
  source = "../modules/subnet"
  vpc_id = module.vpc.vpc_id

  subnets = {
    "public" = {
      cidr_block = "10.0.1.0/24"
      availability_zone = "${var.aws_region}a"
      map_public_ip_on_launch = true
    }
  }

  resource_name_prefix = local.resource_name_prefix 
  tags = local.tags 
}

# module "postgres" {
#   source         = "../modules/db"
#   db_engine      = "postgres"
#   engine_version = "15.4"
#   db_password    = ""
#   tags = local.tags
# }