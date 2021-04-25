if [ "" ==	 "$2" ] ; then
    echo "destination not found"
	exit 1
fi

array=( $IPS )

for ip in "${array[@]}"
do
	echo "scp -r $1  geko@$ip:$2"
	scp -r $1 geko@$ip:$2
done
exit 0
