#!/bin/bash
# baraction.sh script for spectrwm status bar
#DATE
dte(){
    dte=$(date +"%a %b %d %l:%M %p")
    echo -e "$dte"
}
#HDD
hdd(){
    hdd=$(df -h | awk 'NR==4 {print $3,$5}')
    echo -e "HDD $hdd"
}
#CPU
cpu(){
    read cpu a b c previdle rest < /proc/stat
    prevtotal=$((a+b+c+previdle))
    sleep 0.5
    read cpu a b c idle rest < /proc/stat
    total=$((a+b+c+idle))
    cpu=$((100*( (total-prevtotal)-(idle-previdle) )/(total-prevtotal)))
    echo -e "CPU $cpu%"
}
#RAM
mem(){
    #ram=$(awk '/MemFree/ {print $2,$3}' /proc/meminfo)
    ram=$(free | awk '/Mem/ {printf "%d/%d MB",$3/1024.0, $2/1024.0}')
    echo -e "RAM $ram"
}
#VOLUME
vol(){
    vol=$(amixer get Master | awk -F'[][]' 'END{ print $2 }')
    echo -e "VOL $vol"
}
#NETWORK
net(){
    R1=`cat /sys/class/net/wlp6s0/statistics/rx_bytes`
    T1=$(cat /sys/class/net/wlp6s0/statistics/tx_bytes)
    sleep 1
    R2=$(cat /sys/class/net/wlp6s0/statistics/rx_bytes)
    T2=$(cat /sys/class/net/wlp6s0/statistics/tx_bytes)
    TBPS=`expr $T2 - $T1`
    RBPS=$((R2 - R1))
    TKBPS=$((TBPS / 1024))
    RKBPS=$((RBPS / 1024))
    echo -e "NET $RKBPS kb/s $TKBPS kb/s "
}
#BRIGHTNESS
bri(){
    brightness=$(( `cat /sys/class/backlight/intel_backlight/brightness` * 100 / `cat /sys/class/backlight/intel_backlight/max_brightness` ))
    echo -e "BRI $brightness%"
}
#BATERY
bat(){
    echo $(upower -i /org/freedesktop/UPower/devices/battery_BAT0 | awk '/percentage/ {printf "BAT %s", $2}')
}
SLEEP_SEC=1
while :; do
    echo -e "| $(cpu) | $(mem) | $(hdd) | $(net) | $(bri) | $(vol) | $(bat) | $(dte) |"
    sleep $SLEEP_SEC
done
