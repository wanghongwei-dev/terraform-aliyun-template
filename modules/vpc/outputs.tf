output "vpc_id" {
  value       = alicloud_vpc.main.id
  description = "VPC ID"
}

output "vswitch_id" {
  value       = alicloud_vswitch.main.id
  description = "子网 ID"
}