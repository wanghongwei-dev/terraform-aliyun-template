output "ecs_public_ip" {
  value       = alicloud_instance.main.public_ip
  description = "ECS 公网 IP"
}

output "ecs_id" {
  value       = alicloud_instance.main.id
  description = "ECS 实例 ID"
}