#/bin/bash
if [ "$1" == "" ]
  then
    echo "branch missing"
    exit
fi

bash_async.sh "rm -fr /home/geko/cinnamon_test/test/$1"
exit 0

