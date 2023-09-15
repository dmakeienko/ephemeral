### VPC ###
variable "instance_tenancy" {
    type = string
    description = "(optional) describe your variable"
    default = "default"
}


variable "cidr_block" {
    type = string
    description = "(optional) describe your variable"
}


variable "resource_name_prefix" {
    type = string
    description = "(optional) describe your variable"
}


variable "enable_dns_support" {
    type = string
    description = "(optional) describe your variable"
    default = true
}

variable "enable_dns_hostnames" {
    type = string
    description = "(optional) describe your variable"
    default = true
}


variable "domain_name" {
    type = string
    description = "(optional) describe your variable"
    default = null
}

variable "domain_name_servers" {
    type = list(string)
    description = "List of name servers to configure in /etc/resolv.conf"
    default = ["AmazonProvidedDNS"]
}


variable "tags" {
  type        = map(string)
  description = "Map of resource tags"
}