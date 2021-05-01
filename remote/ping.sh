#!/bin/bash
#

no_print=$1
function print(){
    if [ -z "$no_print" ]; then
        printf "$1"
    fi
}
. ~/cute_main_param
array=( $IPS )
let count=0
for ip in "${array[@]}"
do
    print "$ip"
    timeout 0.2 ping -c1 $ip >/dev/null
    if [[ $? -ne 0 ]]; then
        print " *** KO ***\n"
    else
    	let count="count+1"
        print " ok\n"
    fi
done
exit $count

