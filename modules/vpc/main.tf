# 创建 VPC
resource "alicloud_vpc" "main" {
  vpc_name   = var.vpc_name
  cidr_block = var.vpc_cidr
  description = "Created by Terraform VPC module"
}

# 创建子网
resource "alicloud_vswitch" "main" {
  vswitch_name = var.vswitch_name
  cidr_block   = var.vswitch_cidr
  vpc_id       = alicloud_vpc.main.id
  zone_id      = var.zone_id
  description  = "Created by Terraform VSwitch module"
}