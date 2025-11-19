while :; do xsetroot -name "BAT:$(cat /sys/class/power_supply/BAT0/capacity)% $(date)"; sleep 30; done &
