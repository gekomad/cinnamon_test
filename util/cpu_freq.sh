printf "temp: "
cat /sys/devices/virtual/thermal/thermal_zone0/temp
printf "min: "
sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq
printf "max: "
sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq
printf "cur: "
sudo cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_cur_freq
