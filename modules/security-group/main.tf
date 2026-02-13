# 创建安全组
resource "alicloud_security_group" "main" {
  name        = var.sg_name
  vpc_id      = var.vpc_id
  description = "Created by Terraform Security Group module"

  # 动态生成入方向规则（根据传入的端口列表）
  dynamic "ingress" {
    for_each = toset(var.allow_ports)
    content {
      protocol    = "tcp"
      port_range  = "${ingress.value}/${ingress.value}"
      cidr_ip     = "0.0.0.0/0"
      description = "Allow port ${ingress.value} access"
    }
  }

  # 放行所有出方向流量
  egress {
    protocol    = "all"
    port_range  = "-1/-1"
    cidr_ip     = "0.0.0.0/0"
    description = "Allow all outbound traffic"
  }
}