. cute_main_param
array=( $IPS )
for ip in "${array[@]}"
do
	echo "ssh-keygen -f \"/home/geko/.ssh/known_hosts\" -R $ip ;cat ~/.ssh/id_rsa.pub | ssh geko@$ip  \"cat >> .ssh/authorized_keys\";ssh geko@$ip"
	echo
done

