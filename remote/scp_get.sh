array=( $IPS )

for ip in "${array[@]}"
do
	scp  geko@$ip:$1 $2
done
exit 0
