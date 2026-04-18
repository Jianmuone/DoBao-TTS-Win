#!/bin/bash

# DoBao-TTS fnOS Docker Compose 安装脚本

# 1. 创建应用目录
mkdir -p /volume1/docker/dobao-tts
cd /volume1/docker/dobao-tts

# 2. 创建 docker-compose.yml
cat > docker-compose.yml << 'EOF'
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
    mem_limit: 512m
    memswap_limit: 1g
    cpus: 1
    healthcheck:
      test: ["CMD", "wget", "--no-verbose", "--tries=1", "--spider", "http://localhost:3000/"]
      interval: 30s
      timeout: 10s
      retries: 3
      start_period: 10s
EOF

# 3. 创建配置目录和日志目录
mkdir -p config logs

# 4. 启动容器
docker-compose up -d

# 5. 查看容器状态
docker-compose ps

# 6. 查看日志
docker-compose logs -f

echo ""
echo "======================================"
echo "  DoBao-TTS 安装完成！"
echo "======================================"
echo "  访问地址: http://你的服务器IP:3000"
echo ""
echo "  常用命令:"
echo "  - 查看状态: docker-compose ps"
echo "  - 查看日志: docker-compose logs -f"
echo "  - 重启服务: docker-compose restart"
echo "  - 停止服务: docker-compose down"
echo "  - 更新镜像: docker-compose pull && docker-compose up -d"
echo ""
