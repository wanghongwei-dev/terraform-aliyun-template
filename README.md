# 阿里云 Terraform 基础设施部署模板

这是一个用于在阿里云上快速部署基础基础设施的 Terraform 模板，采用模块化设计，支持一键部署包含 VPC、安全组、密钥对和 ECS 实例的完整环境。

## 🏗️ 项目架构

本模板采用模块化设计，包含以下核心组件：

- **VPC 模块**: 创建虚拟私有云网络和子网
- **安全组模块**: 配置网络安全规则
- **密钥对模块**: 管理 SSH 访问密钥
- **ECS 模块**: 部署云服务器实例

## 🚀 快速开始

### 1. 环境准备

确保已安装以下工具：
- [Terraform](https://www.terraform.io/downloads) (版本 >= 1.0)
- 阿里云 CLI 工具（可选）

### 2. 配置认证信息

创建 `terraform.tfvars` 文件并填入您的阿里云凭证：

```hcl
access_key = "your-access-key-id"
secret_key = "your-access-key-secret"
```

### 3. 初始化项目

```bash
terraform init
```

### 4. 部署基础设施

```bash
terraform apply
```

## ⚙️ 配置参数

### 核心配置

| 参数名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| `region` | string | `cn-hangzhou` | 阿里云地域 ID |
| `access_key` | string | - | 阿里云 AccessKey ID |
| `secret_key` | string | - | 阿里云 AccessKey Secret |

### VPC 配置

| 参数名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| `vpc_name` | string | `terraform-demo-vpc` | VPC 名称 |
| `vpc_cidr` | string | `172.16.0.0/16` | VPC 网段 |
| `vswitch_name` | string | `terraform-demo-vswitch` | 子网名称 |
| `vswitch_cidr` | string | `172.16.1.0/24` | 子网网段 |

### 安全组配置

| 参数名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| `sg_name` | string | `terraform-demo-sg` | 安全组名称 |
| `allow_ports` | list(number) | `[22, 80, 443]` | 允许访问的端口列表 |

### ECS 实例配置

| 参数名 | 类型 | 默认值 | 描述 |
|--------|------|--------|------|
| `instance_name` | string | `terraform-demo-ecs` | ECS 实例名称 |
| `instance_type` | string | `ecs.g6.large` | ECS 实例规格 |
| `key_pair_name` | string | `terraform-demo-key` | 密钥对名称 |
| `public_key_path` | string | `${path.module}/id_ed25519.pub` | 本地公钥文件路径 |
| `private_key_path` | string | `~/.ssh/id_ed25519` | 本地私钥文件路径 |

## 📁 项目结构

```
terraform-aliyun-template/
├── main.tf                 # 主配置文件
├── variables.tf            # 变量定义
├── outputs.tf              # 输出定义
├── README.md               # 项目说明文档
├── index.html              # 默认网页文件
├── terraform.tfvars.example # 配置示例文件
└── modules/                # 模块目录
    ├── vpc/                # VPC 模块
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security-group/     # 安全组模块
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── key-pair/           # 密钥对模块
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── ecs/                # ECS 实例模块
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## 🔧 使用示例

### 自定义部署配置

创建自定义的 `terraform.tfvars` 文件：

```hcl
# 阿里云认证信息
access_key = "LTAINr2xxxxxxxxxxxxx"
secret_key = "bCkNbyxxxxxxxxxxxxxxxxxxxx"

# 地域配置
region = "cn-beijing"

# VPC 配置
vpc_name = "my-custom-vpc"
vpc_cidr = "10.0.0.0/16"
vswitch_cidr = "10.0.1.0/24"

# 安全组配置
allow_ports = [22, 80, 443, 3306]

# ECS 配置
instance_name = "web-server"
instance_type = "ecs.c6.large"
```

### 生成 SSH 密钥对

如果还没有 SSH 密钥对，可以使用以下命令生成：

```bash
ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -N ""
```

### 部署后连接 ECS 实例

```bash
ssh -i ~/.ssh/id_ed25519 root@$(terraform output -raw ecs_public_ip)
```

## 📊 输出信息

部署完成后，Terraform 将输出以下关键信息：

- `ecs_public_ip`: ECS 实例公网 IP 地址
- `centos76_image_id`: 使用的 CentOS 7.6 镜像 ID
- `vpc_info`: VPC 和子网 ID 信息
- `security_group_id`: 安全组 ID
- `key_pair_name`: 密钥对名称

## 🔒 安全建议

1. **凭证管理**: 建议使用阿里云 RAM 用户而非主账号，并设置最小权限原则
2. **密钥保护**: 私钥文件应设置适当权限 (`chmod 600`)
3. **网络安全**: 根据实际需求调整安全组规则，避免开放不必要的端口
4. **定期更新**: 及时更新 Terraform 版本和阿里云 Provider

## 🤝 贡献指南

欢迎提交 Issue 和 Pull Request 来改进这个模板！

### 开发流程
1. Fork 项目仓库
2. 创建功能分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 开启 Pull Request

## 📄 许可证

MIT License
