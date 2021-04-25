for a in $(find /home/geko/cinnamon_test/test/ -name "*.pgn"); do
    echo " ----------- $a ------------ "
    pgn-extract -Tr0-1 $a >/tmp/xxb  2>/dev/null
    pgn-extract -Tr1-0 $a >>/tmp/xxb 2>/dev/null
    pgn-extract -Tr1/2-1/2 $a >>/tmp/xxb 2>/dev/null
    ordo -q /tmp/xxb |grep -v advantage |grep -v "^Draw rate"
done
rm /tmp/xxb 2>/dev/null


