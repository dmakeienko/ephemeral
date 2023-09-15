variable "aws_region" {
  default = "eu-central-1"
}

variable "project_name" {
    type = string
    description = ""
    default = "ephemeral"
}

variable "env_id" {
    type = string
    description = "environment id"
    default = "dev1"
}

locals {
    resource_name_prefix = "${var.project_name}-${var.env_id}"
  tags = {
    project_name = var.project_name
    env_id = var.env_id
    "Owner" = "denys.makeienko@gmail.com"
  }
}


variable "db_password" {
  type = string
  description = "(optional) describe your variable"
}