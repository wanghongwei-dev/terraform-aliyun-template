variable "region" {
  type        = string
  description = "阿里云地域 ID"
}

variable "zone_id" {
  type        = string
  description = "阿里云可用区 ID"
}

variable "vpc_name" {
  type        = string
  description = "VPC 名称"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC 网段"
}

variable "vswitch_name" {
  type        = string
  description = "子网名称"
}

variable "vswitch_cidr" {
  type        = string
  description = "子网网段"
}