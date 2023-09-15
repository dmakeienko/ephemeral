terraform {
  backend "s3" {
    bucket = "temptfbackend"
    key    = "ephemeral"
    region = "eu-central-1"
  }
}