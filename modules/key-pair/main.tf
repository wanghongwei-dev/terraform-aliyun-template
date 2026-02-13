# 导入本地公钥创建密钥对
resource "alicloud_key_pair" "main" {
  key_pair_name = var.key_pair_name
  public_key    = file(var.public_key_path)
}