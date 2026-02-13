variable "region" {
  type        = string
  description = "阿里云地域 ID"
}

variable "key_pair_name" {
  type        = string
  description = "密钥对名称"
}

variable "public_key_path" {
  type        = string
  description = "本地公钥文件路径"
}