#! /usr/bin/env bash
# 不喜欢dirty的提示，仅仅用作备份
read -p "extra commit msg:" extra_msg
config_bak=../nixconfig.bak.d
generation=$(nixos-rebuild list-generations | awk 'NR == 2{print $1}' | tr -d '\n\b')
commit_msg=$(
    echo $extra_msg
    echo "generation: "$generation""
)

uuid=$(cat /proc/sys/kernel/random/uuid)
tmp_git="/tmp/$uuid-git"
mv "$config_bak/.git" "$tmp_git"
rsync -ahPv --exclude-from .gitignore --include .gitignore --delete . "$config_bak"

cd "$config_bak"
mv "$tmp_git" .git
git add .
git commit -m "$commit_msg"
git push origin master
cd -