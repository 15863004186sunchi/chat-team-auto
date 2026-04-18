#!/bin/bash
# Docker 部署脚本

echo "正在停止旧容器..."
docker-compose down

echo "正在构建并启动容器..."
docker-compose up --build -d

echo "============================="
echo "  ✅ Docker 部署完成!"
echo "  🌐 访问地址: http://localhost:8503"
echo "  📝 配置文件已挂载: ./config.json"
echo "============================="
