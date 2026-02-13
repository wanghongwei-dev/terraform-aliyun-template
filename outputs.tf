# 汇总所有关键输出
output "ecs_public_ip" {
  value       = module.ecs.ecs_public_ip
  description = "ECS 实例公网 IP"
}

output "centos76_image_id" {
  value       = data.alicloud_images.centos76.images.0.id
  description = "自动查询的 CentOS 7.6 镜像 ID"
}

output "vpc_info" {
  value = {
    vpc_id     = module.vpc.vpc_id
    vswitch_id = module.vpc.vswitch_id
  }
  description = "VPC 和子网 ID"
}

output "security_group_id" {
  value       = module.security_group.sg_id
  description = "安全组 ID"
}

output "key_pair_name" {
  value       = module.key_pair.key_pair_name
  description = "导入的密钥对名称"
}