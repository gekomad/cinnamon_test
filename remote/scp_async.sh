echo "ping..."
. ~/cute_main_param
/home/geko/remote/ping.sh
count=$?
array=( $IPS )
tot="${#array[@]}"

if [[ $tot -ne $count ]]; then
	echo "ping error"
    	exit 1
fi

for ip in "${array[@]}"
do
	echo "scp $1  geko@$ip:$2"
	scp $1  geko@$ip:$2 &
done
exit 0
