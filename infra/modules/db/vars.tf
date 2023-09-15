variable "db_name" {
  type        = string
  description = "The name of the database to create when the DB instance is created"
  default     = null
}

variable "db_engine" {
  type        = string
  description = "The database engine"
}

variable "engine_version" {
  type        = string
  description = "The database engine version"
}


variable "db_instance_tier" {
  type        = string
  description = "The RDS instance class"
  default     = "db.t3.micro"
}

variable "skip_final_snapshot" {
  type        = string
  description = "(etermines whether a final DB snapshot is created before the DB instance is deleted."
  default     = true
}

variable "allocated_storage" {
  type        = number
  description = "The amount of allocated storage"
  default     = 20
}

variable "db_username" {
  type        = string
  description = "psqladmin"
  default     = "psqladmin"
}

variable "db_password" {
  type        = string
  description = "(optional) describe your variable"
}

variable "tags" {
  type        = map(string)
  description = "Map of resource tags"
}

variable "resource_name_prefix" {
  type        = string
  description = "(optional) describe your variable"
}


variable "subnet_ids" {
  type = list(string)
  description = "(optional) describe your variable"
}

variable "db_port" {
  type = string
  description = "(optional) describe your variable"
  default = "5432"
}

variable "allowed_network_cidr" {
  type = list(string)
  description = "(optional) describe your variable"
}

variable "vpc_id" {
  type = string
  description = "(optional) describe your variable"
}