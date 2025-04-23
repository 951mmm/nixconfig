{
  services.acpid = {
    enable = true;
    handlers = {
      mic-led-mute = {
        event = "button/f20.*";
        action = ''
          function log() {
            logger -t mic-led-mute $@
          }
          function get_next_state() {
              local state=$1;
              if [ $state == "1" ]; then
                  echo 0
              else 
                  echo 1
              fi
          }
          function main() {
            state=$(cat /sys/devices/platform/huawei-wmi/leds/platform\:\:micmute/brightness)
            next_state=$(get_next_state $state)

            logger "prev state: $state" "cur state: $next_state"
            logger "======================================="

            echo $next_state > /sys/devices/platform/huawei-wmi/leds/platform\:\:micmute/brightness 
          }

          main
        '';
      };
    };
  };
}
