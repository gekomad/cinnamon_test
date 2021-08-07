if [ "" ==	 "$1" ] ; then
    echo "parameter not found"
	exit 1
fi

bash_async.sh "find /home/geko/cinnamon_test/test/ -name suspend -delete"
exit 0

