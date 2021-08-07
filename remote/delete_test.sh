#/bin/bash

RED='\033[0;31m'
BLUE='\033[0;34m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

for var in "$@"
do
    bash_async.sh "rm -fr /home/geko/cinnamon_test/test/$var"
done
exit 0


