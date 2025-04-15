#! /etc/profiles/per-user/ww/bin/bash 
read -p "extra commit msg:" extra_msg
config_bak=../nixconfig.bak.d
generation=$(nixos-rebuild list-generations | awk 'NR == 2{print $1}' | tr -d '\n\b')
commit_msg=$(
    echo $extra_msg
    echo "generation: "$generation""
)

rsync -ahPv --delete --exclude-from .gitignore --include .gitignore * "$config_bak"
cd "$config_bak"
git add .
git commit -m "$commit_msg"
git push github master
cd -