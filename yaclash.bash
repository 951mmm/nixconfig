#! /usr/bin/env bash
set -u
user=$(whoami)
if [ $user != root ]; then
    echo "切换到root用户执行"
    exit 1
fi

mihomo=/nix/store/01c4zmr8sld836krfpxlqnhkmd0gbmm2-mihomo-1.18.10/bin/mihomo
dectory=/var/lib/private/mihomo
config=$1

reserve() {
    echo 中断临时clash
    echo 恢复mihomo.service
    systemctl start mihomo
}

trap 'reserve' INT TERM
systemctl stop mihomo 
$mihomo -d $dectory -f $config