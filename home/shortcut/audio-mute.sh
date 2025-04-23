#! /bin/sh
state=$(cat /sys/devices/platform/huawei-wmi/leds/platform\:\:micmute/brightness)

function get_next_state() {
    local state=$1;
    if [ $state == "1" ]; then
        echo 0
    else 
        echo 1
    fi
}
next_state=$(get_next_state $state);
echo $next_state > /sys/devices/platform/huawei-wmi/leds/platform\:\:micmute/brightness 