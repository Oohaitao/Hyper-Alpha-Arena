#!/bin/bash

# 遇到错误立即退出
set -e

echo "🚀 开始同步本地代码到 origin/main..."

# 步骤 1: 切换到 main 分支
echo -e "\n[1/4] 切换到 main 分支..."
git checkout main
echo "✅ 成功切换到 main 分支"
sleep 2

# 步骤 2: 获取远程最新信息
echo -e "\n[2/4] 获取远程最新提交（git fetch origin）..."
git fetch origin
echo "✅ 成功获取远程更新"
sleep 2

# 步骤 3: 强制重置为 origin/main
echo -e "\n[3/4] 强制重置本地代码为 origin/main（丢弃所有本地修改）..."
git reset --hard origin/main
echo "✅ 成功重置到 origin/main"
sleep 2

# 步骤 4: 清理未跟踪文件和目录
echo -e "\n[4/4] 清理未跟踪的文件和目录（git clean -fd）..."
git clean -fd
echo "✅ 成功清理未跟踪文件"
sleep 2

echo -e "\n🎉 同步完成！当前代码已与 GitHub 上的 origin/main 完全一致。"