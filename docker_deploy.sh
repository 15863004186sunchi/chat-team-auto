#!/bin/bash
# Docker 部署脚本 (兼容旧版 docker-compose 和新版 docker compose)

# 自动检测 docker-compose 命令
if command -v docker-compose &> /dev/null; then
    DOCKER_COMPOSE="docker-compose"
elif docker compose version &> /dev/null; then
    DOCKER_COMPOSE="docker compose"
else
    echo "❌ 错误: 未找到 docker-compose 或 docker compose。请先安装 Docker Compose。"
    exit 1
fi

echo "使用命令: $DOCKER_COMPOSE"

echo "正在停止旧容器..."
$DOCKER_COMPOSE down

echo "正在构建并启动容器..."
$DOCKER_COMPOSE up --build -d

echo "============================="
echo "  ✅ Docker 部署完成!"
echo "  🌐 访问地址: http://localhost:8503"
echo "  📝 配置文件已挂载: ./config.json"
echo "============================="
