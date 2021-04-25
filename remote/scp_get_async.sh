. ~/cute_main_param
array=( $IPS )

for ip in "${array[@]}"
do
	#nohup scp  geko@$ip:$1 $2  &
	nohup scp  geko@$ip:$1 $2 >/dev/null 2>/dev/null &
done
exit 0
