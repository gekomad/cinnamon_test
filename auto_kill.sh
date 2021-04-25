#! /bin/bash

#*/10 * * * * /home/geko/auto_kill.sh >/dev/null 2>/dev/null

a=$(cat /proc/loadavg|cut -f3 -d" ")
check=$(echo "scale=0;($a * 100)/100" |bc)

if [ "$check" -gt 20 ]; then
    /home/geko/Kill.sh
    echo date >> /home/geko/KILLEDDDDDDDDDDDD
    echo $check >> /home/geko/KILLEDDDDDDDDDDDD
fi
