if [ "" ==	 "$1" ] ; then
    	echo "parameter not found"
    	exit 1
fi

. ~/cute_main_param
echo "ping..."
/home/geko/remote/ping.sh
count=$?
array=( $IPS )
tot="${#array[@]}"
if [[ $count -ne $tot ]]; then
	echo "ping error"
    	exit 1
fi


for ip in "${array[@]}"
do
	echo "ssh geko@$ip "$1""
	#nohup timeout 6h ssh geko@$ip "$1" >/dev/null 2>/dev/null &
	nohup ssh geko@$ip "$1" >/dev/null 2>/dev/null &
	#nohup ssh geko@$ip "$1"  &
done
exit 0
