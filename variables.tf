# 阿里云认证
variable "access_key" {
  type        = string
  description = "阿里云 AccessKey ID"
  sensitive   = true
}

variable "secret_key" {
  type        = string
  description = "阿里云 AccessKey Secret"
  sensitive   = true
}

# 地域
variable "region" {
  type        = string
  description = "阿里云地域 ID"
  default     = "cn-hangzhou"
}

# VPC 配置
variable "vpc_name" {
  type        = string
  description = "VPC 名称"
  default     = "terraform-demo-vpc"
}

variable "vpc_cidr" {
  type        = string
  description = "VPC 网段"
  default     = "172.16.0.0/16"
}

variable "vswitch_name" {
  type        = string
  description = "子网名称"
  default     = "terraform-demo-vswitch"
}

variable "vswitch_cidr" {
  type        = string
  description = "子网网段"
  default     = "172.16.1.0/24"
}

# 安全组配置
variable "sg_name" {
  type        = string
  description = "安全组名称"
  default     = "terraform-demo-sg"
}

variable "allow_ports" {
  type        = list(number)
  description = "需要放行的端口列表"
  default     = [22, 80, 443]
}

# 密钥对配置
variable "key_pair_name" {
  type        = string
  description = "密钥对名称"
  default     = "terraform-demo-key"
}

variable "public_key_path" {
  type        = string
  description = "本地公钥文件路径"
  default     = "${path.module}/id_ed25519.pub"
}

variable "private_key_path" {
  type        = string
  description = "本地私钥文件路径（SSH 连接用）"
  sensitive   = true
  default     = "~/.ssh/id_ed25519"
}

# ECS 配置
variable "instance_name" {
  type        = string
  description = "ECS 实例名称"
  default     = "terraform-demo-ecs"
}

variable "instance_type" {
  type        = string
  description = "ECS 实例规格"
  default     = "ecs.g6.large"
}

# HTML 文件配置
variable "html_file_path" {
  type        = string
  description = "本地自定义 HTML 文件路径"
  default     = "${path.module}/index.html"
}