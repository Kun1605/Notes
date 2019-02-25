#!/bin/bash

echo "git add ."
git add .

echo "git commit"
echo "请输入commit的注释信息:"
comment="commit new code"
read comment
git commit -m "$comment"

echo "git fetch origin master"
git fetch origin master

echo "git merge origin/master"
git merge origin/master

echo "git push origin master:master"
git push origin master:master
