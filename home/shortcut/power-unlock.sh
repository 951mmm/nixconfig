#! /bin/sh
power_unlock_state=$(cat /sys/devices/platform/huawei-wmi/power_unlock)
msg=性能模式
if [ $power_unlock_state == "1" ]; then
    notify-send "$msg: 开启"
else 
    notify-send "$msg: 关闭"
fi