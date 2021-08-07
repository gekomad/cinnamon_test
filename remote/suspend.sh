if [ "" ==	 "$1" ] ; then
    echo "parameter not found"
	exit 1
fi

bash_async.sh "touch /home/geko/cinnamon_test/test/$1/suspend"
exit 0

