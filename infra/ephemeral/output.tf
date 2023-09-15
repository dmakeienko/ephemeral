output "vpc" {
  value = module.vpc
}

output "rds_subnets" {
  value = module.rds_subnets
}

output "db" {
  value = module.postgres
}