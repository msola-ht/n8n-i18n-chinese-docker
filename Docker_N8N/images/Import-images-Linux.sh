#!/bin/bash

# 导入Docker镜像脚本
# Docker 镜像导入脚本
# 版权所有 (c) 老何的AIGC研究室

echo "================================"
echo "导入Docker镜像脚本"
echo "================================"
echo ""

# 切换到脚本所在目录
cd "$(dirname "$0")"

echo "当前目录: $(pwd)"
echo ""

# 检查Docker是否运行
echo "检查Docker状态..."
if ! command -v docker &> /dev/null; then
    echo "错误：Docker未运行或未安装！"
    echo "请先启动Docker Desktop"
    read -p "按回车键退出..."
    exit 1
fi

echo " Docker已运行"
echo ""

# 查找当前目录下的所有镜像文件
echo "================================"
echo "扫描当前目录的镜像文件..."
echo "================================"
echo ""

# 初始化计数器
count=0

# 遍历所有 .tar 和 .tar.gz 文件
for file in *.tar *.tar.gz; do
    if [ -f "$file" ]; then
        count=$((count + 1))
        echo "发现镜像文件: $file"
    fi
done

echo ""
echo "共找到 $count 个镜像文件"
echo ""

# 如果没有找到镜像文件，退出
if [ $count -eq 0 ]; then
    echo "警告：当前目录下没有找到任何 .tar 或 .tar.gz 镜像文件！"
    echo "请确保镜像文件位于: $(pwd)"
    read -p "按回车键退出..."
    exit 1
fi

echo "================================"
echo "开始导入镜像..."
echo "================================"
echo ""

success=0
failed=0

# 导入所有镜像文件
for file in *.tar *.tar.gz; do
    if [ -f "$file" ]; then
        echo "-----------------------------------"
        echo "正在导入: $file"
        echo "-----------------------------------"

        if docker load -i "$file"; then
            echo " $file 导入成功"
            success=$((success + 1))
        else
            echo " $file 导入失败"
            failed=$((failed + 1))
        fi
        echo ""
    fi
done

# 显示导入统计
echo "================================"
echo "导入统计"
echo "================================"
echo " 成功: $success 个"
echo " 失败: $failed 个"
echo " 总计: $count 个"
echo ""

echo "================================"
echo "导入完成！"
echo "================================"
echo ""
echo "现在可以使用 docker-compose up -d 启动服务"

echo ""
echo "启动完毕.按回车键退出."
echo "版权所有 (c) 老何的AIGC研究室"
read -p ""
