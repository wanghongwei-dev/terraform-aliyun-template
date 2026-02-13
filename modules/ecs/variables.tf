variable "region" {
  type        = string
  description = "阿里云地域 ID"
}

variable "zone_id" {
  type        = string
  description = "阿里云可用区 ID"
}

variable "instance_name" {
  type        = string
  description = "ECS 实例名称"
}

variable "instance_type" {
  type        = string
  description = "ECS 实例规格"
}

variable "image_id" {
  type        = string
  description = "镜像 ID（由根模块传递）"
}

variable "vswitch_id" {
  type        = string
  description = "子网 ID"
}

variable "security_group_id" {
  type        = string
  description = "安全组 ID"
}

variable "key_pair_name" {
  type        = string
  description = "密钥对名称"
}

variable "private_key_path" {
  type        = string
  description = "本地私钥文件路径"
  sensitive   = true
}

variable "html_file_path" {
  type        = string
  description = "本地 HTML 文件路径"
}