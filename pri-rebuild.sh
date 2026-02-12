#!/bin/bash

set -e  # 遇错即停

echo "🔄 开始执行应用重建流程..."

# 步骤 1: 停止所有由 docker-compose 启动的容器
echo -e "\n[1/4] 停止 Docker Compose 容器..."
docker-compose stop
echo "✅ 成功停止所有 compose 容器"
sleep 2

# 步骤 2: 删除指定容器（hyper-arena-app）
echo -e "\n[2/4] 删除容器 'hyper-arena-app'..."
# 使用 -f 确保即使容器不存在也不报错
docker rm -f hyper-arena-app 2>/dev/null || echo "⚠️ 容器 'hyper-arena-app' 不存在或已删除"
echo "✅ 容器清理完成"
sleep 2

# 步骤 3: 清理hyper-alpha-arena_app和悬空镜像（不会删除正在使用的镜像）
docker rmi hyper-alpha-arena_app
echo "✅ hyper-alpha-arena_app镜像已清理"
echo -e "\n[3/4] 清理悬空 Docker 镜像..."
docker image prune -f
echo "✅ 悬空镜像已清理"
sleep 2

# 步骤 4: 执行 Git 强制同步脚本
echo -e "\n[4/4] 执行 Git 同步脚本 './git-sync.sh'..."
if [ -f "./git-sync.sh" ]; then
    chmod +x ./git-sync.sh  # 确保有执行权限
    ./git-sync.sh
else
    echo "❌ 错误：未找到 './git-sync.sh' 脚本！"
    exit 1
fi
echo "✅ Git 同步已完成"
chmod -R 777 pri-rebuild.sh
echo "✅ 脚本添加权限已完成"
echo -e "\n🎉 应用重建准备完成！可运行 'docker-compose up -d --build' 启动新版本。"