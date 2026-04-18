#!/bin/bash
# ============================================================
# 首次部署前的准备脚本
# 在 VPS 上 git clone 后, 先运行这个脚本!
# ============================================================

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG_FILE="$SCRIPT_DIR/config.json"
EXAMPLE_FILE="$SCRIPT_DIR/config.example.json"

echo "============================="
echo "  ABCard - 部署准备"
echo "============================="

# 1. 创建 config.json
if [ ! -f "$CONFIG_FILE" ]; then
    echo ""
    echo "[1/2] 未发现 config.json, 从模板创建..."
    cp "$EXAMPLE_FILE" "$CONFIG_FILE"
    echo "  ✅ 已创建: $CONFIG_FILE"
    echo "  ⚠️  请编辑 config.json 填写 YesCaptcha Key, 邮箱 Worker 等信息!"
    echo "  命令: nano $CONFIG_FILE"
else
    echo ""
    echo "[1/2] ✅ config.json 已存在, 跳过"
fi

# 2. 创建 test_outputs 目录 (用于存放运行结果)
mkdir -p "$SCRIPT_DIR/test_outputs"
echo ""
echo "[2/2] ✅ test_outputs 目录已就绪"

echo ""
echo "============================="
echo "  准备完成! 接下来:"
echo "  1. 编辑配置: nano $CONFIG_FILE"
echo "  2. 启动服务: ./docker_deploy.sh"
echo "============================="
