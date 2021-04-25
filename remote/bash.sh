if [ "" ==	 "$1" ] ; then
    echo "parameter not found"
	exit 1
fi
. ~/cute_main_param
array=( $IPS )

for ip in "${array[@]}"
do
	echo "--------------------------- ssh geko@$ip "$1"------------------------"
	#nohup ssh geko@$ip "$1" &
	ssh geko@$ip "$1"
	echo
done
exit 0
