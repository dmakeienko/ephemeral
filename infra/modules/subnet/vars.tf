variable "tags" {
  type        = map(string)
  description = "Map of resource tags"
}

variable "resource_name_prefix" {
  type        = string
  description = "(optional) describe your variable"
}


variable "subnets" {
    type = map(object({
        cidr_block = string
      availability_zone = string
      map_public_ip_on_launch = bool
    }))
}

variable "vpc_id" {
    type = string
    description = "(optional) describe your variable"
}