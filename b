#!/bin/bash
#

function print() {
    for i in `seq 1 $1`; do
        printf "."
    sleep 2
    done
}

ping.sh no_print
count=$?
killall scp 2>/dev/null
rm -fr /tmp/cute_pgn
. ~/cute_main_param
. ./cute_main_param

first_uci_name=$(echo "uci" > /tmp/uciname;echo "quit" >> /tmp/uciname; $first < /tmp/uciname|grep "^id name"|cut -c9-50)
echo "first_uci_name $first_uci_name"
bash_async.sh ". ~/cute_main_param;rm -fr /tmp/cute_pgn;mkdir /tmp/cute_pgn;find /home/geko/cinnamon_test -type d -name ".git" -prune -o  -name "*.pgn"  -exec cp {} /tmp/cute_pgn \;; tar -cf /tmp/cute_pgn_\$id.tar /tmp/cute_pgn 2>/dev/null && touch /tmp/cute_pgn_\$id.ok" ignore_err
mkdir /tmp/cute_pgn 2>/dev/null
sleep 3
scp_get_async.sh "/tmp/cute_pgn_??????.ok" /tmp/cute_pgn
while [[ $(find /tmp/cute_pgn -type f -name 'cute_pgn_??????.ok' -printf x | wc -c) != $count ]]; do
    print 4
done
rm /tmp/cute_pgn/*.ok
scp_get_async.sh "/tmp/{cute_pgn_??????.tar,cute_pgn_??????.ok}" /tmp/cute_pgn
c=0
until [[ $c == $count ]]; do
  c=$(find /tmp/cute_pgn -type f -name 'cute_pgn_??????.ok' -printf x | wc -c)
  printf " downloaded: $c "
  print 2
done

echo "download ok"
cd /tmp/cute_pgn

for f in *.tar; do tar -xf "$f"; done
rm /tmp/cute_pgn/* 2>/dev/null
cd /tmp/cute_pgn/tmp/cute_pgn
rm /tmp/res1 2>/dev/null
a=$(find ./ -type f -size +40c -printf "%f\n" | grep "\.pgn" | rev | cut -f2,3,4,5,6,7,8,9,10 -d"-" | rev | sort -u)

if true ; then
  for fn in $a; do
    echo " ----------- _test_/$fn ------------ "
    echo "32bit"
    cat $fn-*c491f8.pgn $fn-*3918d4.pgn $fn-*999bd5.pgn $fn-*1f2bde.pgn $fn-*046a1b.pgn $fn-*860b0e.pgn $fn-*03d404.pgn $fn-*79a5ed.pgn >32
    #pgn-extract -Tr0-1 32 >a 2>/dev/null
    #pgn-extract -Tr1-0 32 >>a 2>/dev/null
    #pgn-extract -Tr1/2-1/2 32 >>a 2>/dev/null;mv a 32
    ordo -a $first_elo -p 32 -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null
    grep -v "^White" /tmp/$fn.txt | grep -v "^Draw"
    echo "64bit"
    cat $fn-*12387e.pgn $fn-*658a17.pgn $fn-*5ee45e.pgn $fn-*1f7e3d.pgn $fn-*cb8ba2.pgn $fn-*b9e6f5.pgn $fn-*6d3d39.pgn $fn-*ea797f.pgn >64
    #pgn-extract -Tr0-1 64 >a 2>/dev/null
    #pgn-extract -Tr1-0 64 >>a 2>/dev/null
    #pgn-extract -Tr1/2-1/2 64 >>a 2>/dev/null;mv a 64
    ordo -a $first_elo -p 64 -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null
    grep -v "^White" /tmp/$fn.txt | grep -v "^Draw"
    echo "tot"
    cat 32 64 >tot
    ordo -a $first_elo -p tot -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null
    grep -v "^White" /tmp/$fn.txt | grep -v "^Draw"
  done
else
  for fn in $a; do
    echo " ----------- _test_/$fn ------------ "
    cat $fn-??????.pgn >a
#    pgn-extract -Tr0-1 a >b 2>/dev/null
#    pgn-extract -Tr1-0 a >>b 2>/dev/null
#    pgn-extract -Tr1/2-1/2 a >>b 2>/dev/null
#    mv b a
    ordo -a $first_elo -p a -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null
    grep -v "^White" /tmp/$fn.txt | grep -v "^Draw"
  done
fi

date
exit 0
