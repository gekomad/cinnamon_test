#!/bin/bash
#
. /home/geko/cute_main_param
array=( $IPS )
let count=0
for ip in "${array[@]}"
do
    printf "$ip"
    timeout 0.2 ping -c1 $ip >/dev/null
    if [[ $? -ne 0 ]]; then
        echo " *** KO ***"
    else
	let count="count+1"
        echo " ok"
    fi
done
exit $count

