# 创建 ECS 实例
resource "alicloud_instance" "main" {
  instance_name              = var.instance_name
  image_id                   = var.image_id
  instance_type              = var.instance_type
  security_groups            = [var.security_group_id]
  vswitch_id                 = var.vswitch_id
  key_name                   = var.key_pair_name
  internet_charge_type       = "PayByTraffic"
  internet_max_bandwidth_out = 100
  allocate_public_ip         = true

  # 系统盘配置
  system_disk_category = "cloud_essd"
  system_disk_size     = 40

  # SSH 连接配置
  connection {
    type        = "ssh"
    user        = "root"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    port        = 22
    timeout     = "5m"
  }

  # 上传本地 HTML 文件
  provisioner "file" {
    source      = var.html_file_path
    destination = "/usr/share/nginx/html/index.html"
    before_upload = "mkdir -p /usr/share/nginx/html"
  }

  # 安装 Docker
  provisioner "remote-exec" {
    inline = [
      "yum install -y yum-utils device-mapper-persistent-data lvm2",
      "yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo",
      "yum install -y docker-ce docker-ce-cli containerd.io -y",
      "systemctl start docker",
      "systemctl enable docker",
      "usermod -aG docker root"
    ]
  }

  # 运行 Nginx 容器
  provisioner "remote-exec" {
    inline = [
      "docker rm -f nginx-demo || true",
      "docker run -d --name nginx-demo \
        -p 80:80 -p 443:443 \
        -v /usr/share/nginx/html/index.html:/usr/share/nginx/html/index.html \
        nginx:latest"
    ]
  }
}