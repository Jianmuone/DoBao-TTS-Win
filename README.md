# DoBao-TTS Docker 部署指南

豆包 TTS 服务 Docker 版本，支持快速部署到各种平台。

## 🚀 快速开始

### 1. 拉取镜像

构建完成后，可以使用以下命令拉取镜像：

```bash
docker pull ghcr.io/YOUR_USERNAME/dobao-tts:latest
```

### 2. 运行容器

#### 使用 Docker 运行

```bash
docker run -d \
  --name dob ao-tts \
  -p 3000:3000 \
  -v ./config:/app/config \
  -v ./logs:/app/logs \
  --restart unless-stopped \
  ghcr.io/YOUR_USERNAME/dobao-tts:latest
```

#### 使用 Docker Compose

```yaml
services:
  dob ao-tts:
    image: ghcr.io/YOUR_USERNAME/dobao-tts:latest
    container_name: dob ao-tts
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - HOST=0.0.0.0
      - PORT=3000
    volumes:
      - ./config:/app/config
      - ./logs:/app/logs
    restart: unless-stopped
```

## 🐳 fnOS / 群晖 / UNRAID 安装

### 方法 1：Docker Compose（推荐）

在 Docker Compose 管理界面中粘贴以下内容：

```yaml
version: '3.8'

services:
  dob ao-tts:
    image: ghcr.io/YOUR_USERNAME/dobao-tts:latest
    container_name: dob ao-tts
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - HOST=0.0.0.0
      - PORT=3000
    volumes:
      - /path/to/config:/app/config
      - /path/to/logs:/app/logs
    restart: unless-stopped
    mem_limit: 512m
    cpus: 1
```

### 方法 2：命令行安装

```bash
# 创建目录
mkdir -p /volume1/docker/dobao-tts/{config,logs}

# 进入目录
cd /volume1/docker/dobao-tts

# 创建 docker-compose.yml
cat > docker-compose.yml << 'EOF'
services:
  dob ao-tts:
    image: ghcr.io/YOUR_USERNAME/dobao-tts:latest
    container_name: dob ao-tts
    ports:
      - "3000:3000"
    volumes:
      - ./config:/app/config
      - ./logs:/app/logs
    restart: unless-stopped
EOF

# 启动服务
docker-compose up -d
```

## 🌐 访问服务

安装完成后，通过浏览器访问：

```
http://你的服务器IP:3000
```

## 📝 常用命令

```bash
# 查看容器状态
docker ps

# 查看日志
docker logs -f dob ao-tts

# 重启服务
docker restart dob ao-tts

# 停止服务
docker docker stop dob ao-tts

# 更新镜像
docker-compose pull && docker-compose up -d
```

## 🔧 数据持久化

- **配置文件**: `./config` - TTS 和语音配置
- **日志文件**: `./logs` - 应用日志

## ⚠️ 常见问题

### 1. 拉取镜像失败

如果遇到 `denied` 错误：

```bash
# 方法 1：登录后再拉取
docker login ghcr.io -u YOUR_USERNAME
docker pull ghcr.io/YOUR_USERNAME/dobao-tts:latest

# 方法 2：手动设置为公开
# 访问 https://github.com/YOUR_USERNAME/DoBao-TTS-Win/settings/packages
# 将包设置为 Public
```

### 2. 端口冲突

如果 3000 端口被占用，修改 docker-compose.yml：

```yaml
ports:
  - "3001:3000"  # 改为 3001
```

### 3. 权限问题

确保目录有正确的权限：

```bash
chmod -R 755 ./config ./logs
```

## 📦 本地构建

如果你想本地构建镜像：

```bash
# 克隆仓库
git clone https://github.com/YOUR_USERNAME/DoBao-TTS-Win.git
cd DoBao-TTS-Win

# 构建镜像
docker build -t dob ao-tts:latest .

# 运行
docker run -d -p 3000:3000 dob ao-tts:latest
```

## 🔄 自动更新

### Watchtower（推荐）

```yaml
services:
  dob ao-tts:
    image: ghcr.io/YOUR_USERNAME/dobao-tts:latest
    # ... 其他配置

  watchtower:
    image: containrrr/watchtower
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    command: --interval 86400 dob ao-tts
    restart: unless-stopped
```

## 📚 相关资源

- [GitHub 仓库](https://github.com/YOUR_USERNAME/DoBao-TTS-Win)
- [Docker Hub 镜像](https://hub.docker.com/r/YOUR_USERNAME/dobao-tts)

## 🤝 贡献

欢迎提交 Issue 和 Pull Request！

## 📄 许可证

MIT License
