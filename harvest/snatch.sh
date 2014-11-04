#!/bin/bash
# run every 5 minutes.
# for each road in routeIds, download data, parse, save in "date time".csv
# parsing example in test.sh.

for((i=$(wc -l /home/phil/traffic2/routeIds.dat |awk '{print $1}'); i > 0; i--)); do road=$(tail -$i /home/phil/traffic2/routeIds.dat |head -1); curl --connect-timeout 30 -s -H "Accept:application/json, text/javascript, */*; q=0.01" -H "Content-Type:application/json; charset=UTF-8" -d "{routeId: '$road'}" http://www.naftemporiki.gr/traffic/default.aspx/LoadRoutes |/usr/local/bin/json_pp |sed 's/Από:/\nΑπό:/g' |sed 's/<\/h3>.*startPin\W//' |sed 's/, \WΑρχή Διαδρομής.*endPin\W//' |sed 's/\WΤέλος .*<strong>Έως:<\/strong>/Έως: /' |sed 's/<\/div>.*Κατεύθυνση:<\/strong>/, /' |sed 's/<\/div>.*Μήκος:<\/strong>/, /' |sed 's/<\/div><div class=\Wrow\W><strong>Ταχ.:<\/strong>/, /' |sed 's/<\/div>.*$//' |grep "Από:" |sed 's/[ ]*,/,/g; s/,[ ]*/,/g' |sed 's/Από: //; s/Έως: //; s/ΠΡΟΣ //; s/ χμ\.//; s/ χμ\/ω//' |sed 's/ )/)/' |sed "s/^/${road},/" ;done > /home/phil/traffic2/"$(date --rfc-3339=seconds)".csv

