if [ "" ==	 "$1" ] ; then
    	echo "parameter not found"
    	exit 1
fi

. ~/cute_main_param
echo "ping..."
ping.sh
count=$?
array=( $IPS )
tot="${#array[@]}"
if [[ $count -ne $tot ]]; then
	echo "ping error ************* no changes made ***************"
    if [ "" ==	 "$2" ] ; then
    	exit 1
    fi

fi


for ip in "${array[@]}"
do
	echo "ssh geko@$ip "$1""
	nohup ssh geko@$ip "$1" >/dev/null 2>/dev/null &
done
exit 0
