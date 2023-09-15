terraform {
  required_version = "1.5.7"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.16"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      project_name = var.project_name
      env_id       = var.env_id
      "Owner"      = "denys.makeienko@gmail.com"
    }
  }
}