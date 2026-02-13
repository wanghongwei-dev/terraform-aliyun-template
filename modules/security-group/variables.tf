variable "region" {
  type        = string
  description = "阿里云地域 ID"
}

variable "sg_name" {
  type        = string
  description = "安全组名称"
}

variable "vpc_id" {
  type        = string
  description = "所属 VPC ID"
}

variable "allow_ports" {
  type        = list(number)
  description = "需要放行的端口列表"
}