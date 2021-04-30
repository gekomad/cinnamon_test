
#!/bin/bash
#
echo "ping..."
ping.sh
        count=$?
              killall scp 2>/dev/null
        rm -fr /tmp/cute_pgn
. ~/cute_main_param
        bash_async.sh ". ~/cute_main_param;rm -fr /tmp/cute_pgn;mkdir /tmp/cute_pgn;find /home/geko/cinnamon_test -type d -name ".git" -prune -o  -name "*.pgn"  -exec cp {} /tmp/cute_pgn \;; tar -cf /tmp/cute_pgn_\$id.tar /tmp/cute_pgn 2>/dev/null && touch /tmp/cute_pgn_\$id.ok"  ignore_err
        mkdir /tmp/cute_pgn 2>/dev/null
        sleep 3
scp_get_async.sh "/tmp/cute_pgn_??????.ok" /tmp/cute_pgn
while [[ $(find /tmp/cute_pgn -type f -name 'cute_pgn_??????.ok' -printf x | wc -c) != $count ]]
do
sleep 2;printf ".";sleep 2;printf ".";sleep 2;printf ".";sleep 2;printf "."
done
rm /tmp/cute_pgn/*.ok
scp_get_async.sh "/tmp/{cute_pgn_??????.tar,cute_pgn_??????.ok}" /tmp/cute_pgn
c=0
until [[ $c == $count ]]
do
    c=$(find /tmp/cute_pgn -type f -name 'cute_pgn_??????.ok' -printf x | wc -c)
    printf "count: $c "
    sleep 2;printf ".";sleep 2;printf ".";
done

echo "download ok"
cd /tmp/cute_pgn 

for f in *.tar; do tar -xf "$f"; done
rm /tmp/cute_pgn/* 2>/dev/null
cd /tmp/cute_pgn/tmp/cute_pgn
rm /tmp/res1 2>/dev/null
a=$(find ./  -type f -size +40c -printf "%f\n"|grep "\.pgn"|rev|cut -f2,3,4,5,6,7,8,9,10 -d"-"|rev|sort -u)
#for fn in $a; do
#    echo " ----------- _test_/$fn ------------ "
#echo "32bit"
#    cat *c491f8* *3918d4* *999bd5* *1f2bde* *046a1b* *860b0e* *03d404* *79a5ed* >32
#    cat *12387e* *658a17* *5ee45e* *1f7e3d* *cb8ba2* *b9e6f5* *6d3d39* *ea797f* >64
#    pgn-extract -Tr0-1     32 >b  2>/dev/null
#    pgn-extract -Tr1-0  32 >>b 2>/dev/null
#    pgn-extract -Tr1/2-1/2   32 >>b 2>/dev/null
#    ordo -a $first_elo -p b -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null  ;grep -v "^White" /tmp/$fn.txt|grep -v "^Draw"
#echo "64bit"
#    pgn-extract -Tr0-1      64 >c  2>/dev/null
#    pgn-extract -Tr1-0   64 >>c 2>/dev/null
#    pgn-extract -Tr1/2-1/2    64 >>c 2>/dev/null
#    ordo -a $first_elo -p c -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null  ;grep -v "^White" /tmp/$fn.txt|grep -v "^Draw"
#echo "tot"
#    cat b c >a
#    ordo -a $first_elo -p a -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null  ;grep -v "^White" /tmp/$fn.txt|grep -v "^Draw"
#done
for fn in $a; do
    echo " ----------- _test_/$fn ------------ "
    cat $fn-??????.pgn >a
    pgn-extract -Tr0-1     a >b  2>/dev/null
    pgn-extract -Tr1-0  a >>b 2>/dev/null
    pgn-extract -Tr1/2-1/2    a >>b 2>/dev/null
    mv b a
    ordo -a $first_elo -p a -A "$first_uci_name" -o /tmp/$fn.txt >/dev/null  ;grep -v "^White" /tmp/$fn.txt|grep -v "^Draw"
done
rm nohup 2>/dev/null
#cat /tmp/res1
date
exit 0

