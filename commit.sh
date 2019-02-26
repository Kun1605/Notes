#!/bin/bash

echo "正在添加全局索引"
git add .

echo "提交代码到暂存区"
echo "请输入commit的注释信息:"
comment="commit new code"
read comment
git commit -m "$comment"

echo "正在检查更新"
git fetch origin master

echo "git merge origin/master"
git merge origin/master

echo "git push origin master:master"
git push origin master:master
