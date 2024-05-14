variable "cluster_identifier" {
  type = string
  default= ""
}


variable "cluster_node_type" {
  type = string
  default= ""
}

variable "cluster_number_of_nodes" {
  type = string
  default= ""
}

variable "automated_snapshot_retention_period" {
  type = string
  default= ""
}

variable "snapshot_identifier" {
  type = string
  default= ""
}

variable "subnets" {
  type = list(string)
  default= []
}

#variable "vpc_security_group_ids" {
#  type = list(string)
#  default= []
#}

variable "sg_name" {
  type = string
  default= ""
}

variable "sg_tags" {
  type = string
  default= ""
}

variable "vpc_id" {
  type = string
  default= ""
}



variable "cluster_master_username" {
  type = string
  default= ""
}

variable "cluster_master_password" {
  type = string
  default= ""
}


variable "cluster_database_name" {
  type = string
  default= ""
}

variable "owner_account" {
  type = string
  default= ""
}
