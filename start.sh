#!/bin/bash
# 自动清理 Xvfb 锁文件
echo "Cleaning up Xvfb locks..."
rm -rf /tmp/.X99-lock /tmp/.X11-unix/X99

# 启动虚拟显示器
echo "Starting Xvfb..."
Xvfb :99 -screen 0 1280x720x24 -ac -nolisten tcp &

# 等待 Xvfb 启动
sleep 2

# 启动 Streamlit
echo "Starting Streamlit..."
exec streamlit run ui.py --server.port 8503 --server.address 0.0.0.0
