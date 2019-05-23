#!/bin/bash

echo "正在添加全局索引"
git add .

echo "提交代码到暂存区"
echo "请输入commit的注释信息:"
comment="commit new code"
#read comment
git commit -m "日常提交代码"

echo "正在检查更新"
git fetch origin master

echo "正在合并主干"
git merge origin/master

echo "提交主干到master"
git config credential.helper store
git push origin master:master
