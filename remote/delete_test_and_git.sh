#/bin/bash
if [ "$1" == "" ]
  then
    echo "branch missing"
    exit
fi

bash_async.sh "rm -fr /home/geko/cinnamon_test/test/$1"
git_delete_branch_tag.sh _test_/$1
exit 0

