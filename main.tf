# 配置阿里云 Provider
terraform {
  required_providers {
    alicloud = {
      source  = "aliyun/alicloud"
      version = "~> 1.203.0"
    }
  }
}

provider "alicloud" {
  access_key = var.access_key
  secret_key = var.secret_key
  region     = var.region
}

# 查询可用区
data "alicloud_zones" "ecs_zones" {
  region_id                   = var.region
  available_resource_creation = "Instance"
  available_instance_type     = var.instance_type # 匹配 ECS 实例规格
}

# 自动查询 CentOS 7.6 镜像 ID（根模块统一查询，传递给 ECS 模块）
data "alicloud_images" "centos76" {
  name_regex  = "^centos_7_6_x64_20G_alibase.*"
  owners      = "system"
  most_recent = true
}

# 1. 调用 VPC 模块
module "vpc" {
  source     = "./modules/vpc"
  region     = var.region
  zone_id    = data.alicloud_zones.ecs_zones.zones.0.id # 自动选第一个可用区
  vpc_name   = var.vpc_name
  vpc_cidr   = var.vpc_cidr
  vswitch_name = var.vswitch_name
  vswitch_cidr = var.vswitch_cidr
}

# 2. 调用安全组模块
module "security_group" {
  source     = "./modules/security-group"
  region     = var.region
  sg_name    = var.sg_name
  vpc_id     = module.vpc.vpc_id
  # 放行的端口列表（可通过变量灵活配置）
  allow_ports = var.allow_ports
}

# 3. 调用密钥对模块
module "key_pair" {
  source          = "./modules/key-pair"
  region          = var.region
  key_pair_name   = var.key_pair_name
  public_key_path = var.public_key_path
}

# 4. 调用 ECS 模块
module "ecs" {
  source           = "./modules/ecs"
  region           = var.region
  zone_id          = data.alicloud_zones.ecs_zones.zones.0.id # 与 VPC 子网同可用区
  instance_name    = var.instance_name
  instance_type    = var.instance_type
  image_id         = data.alicloud_images.centos76.images.0.id
  vswitch_id       = module.vpc.vswitch_id
  security_group_id = module.security_group.sg_id
  key_pair_name    = module.key_pair.key_pair_name
  private_key_path = var.private_key_path
  html_file_path   = var.html_file_path
}