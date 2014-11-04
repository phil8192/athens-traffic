#!/bin/bash
# test parsing part of snatch.sh
# converts $raw_data into this:
#   phil@Stalker:~/traffic$ ./test.sh 
#   Λ.ΣΥΓΓΡΟΥ,ΥΨΟΣ ΔΑΒΑΚΗ,23.707248,37.949477,23.647428,37.948159,ΠΛ.ΙΠΠΟΔΑΜΕΙΑΣ (ΠΕΙΡΑΙΑΣ) (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ-ΜΙΚΡΑΣ ΑΣΙΑΣ),ΠΕΙΡΑΙΑ,6135,67 
#   Λ.ΣΥΓΓΡΟΥ,ΥΨΟΣ ΔΑΒΑΚΗ,23.707248,37.949477,23.736802,37.871828,ΓΛΥΦΑΔΑ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ),ΓΛΥΦΑΔΑ,11321,71 
#   Λ.ΣΥΓΓΡΟΥ,ΥΨΟΣ ΔΑΒΑΚΗ,23.707248,37.949477,23.717512,37.906117,Λ.ΑΛΙΜΟΥ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ),ΓΛΥΦΑΔΑ,7028,71 
#
# result corresponds to data in right hand side column of naftemporiki-traffic.png screenshot.
# (screenshot taken ~12.30am 2014-11-04 GMT (2.30am EET)  
# where last column in extracted data = average speed. (kmph)
# penultimate column = distance of road segment (km).
#
# greek:   Διαδρομές, Από, long1, lat1, long2, lat2, Έως, Κατεύθυνση, Μήκος, Ταχ.
# english: route, from, long1, lat1, long2, lat2, until(to), direction, length, speed.

raw_data=$(cat << EOF
{"d":"\u003cdiv\u003e \u003ch2 id=\"h2Road\" runat=\"server\" class=\"resultsTitle\"\u003e Λ.ΣΥΓΓΡΟΥ\u003c/h2\u003e\u003cul\u003e \u003ch3 \u003eΑπό: ΥΨΟΣ ΔΑΒΑΚΗ\u003c/h3\u003e\u003ca href=\"javascript:void(0)\" onclick=\" addPin(\u0027startPin\u0027, 23.707248 , 37.949477  , \u0027Αρχή Διαδρομής\u0027, \u0027/traffic/images/start.png\u0027 ); addPin(\u0027endPin\u0027, 23.647428 , 37.948159 , \u0027Τέλος Διαδρομής\u0027 , \u0027/traffic/images/end.png\u0027); map.moveTo(new telenavis.WorldPoint( 23.672874 , 37.944278  ,4326),12) \" title=\"Προβολή διαδρομής στο χάρτη\" \u003e\u003cli id=\u0027liColor\u0027 class=\u0027green\u0027 runat=\u0027server\u0027\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΈως:\u003c/strong\u003eΠΛ.ΙΠΠΟΔΑΜΕΙΑΣ (ΠΕΙΡΑΙΑΣ) (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ-ΜΙΚΡΑΣ ΑΣΙΑΣ )\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΚατεύθυνση:\u003c/strong\u003eΠΡΟΣ ΠΕΙΡΑΙΑ\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΜήκος:\u003c/strong\u003e6135 χμ.\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΤαχ.:\u003c/strong\u003e67 χμ/ω \u003c/div\u003e \u003cdiv\u003e5 λεπτά \u003c/div\u003e\u003c/li\u003e\u003c/a\u003e \u003ch3 \u003eΑπό: ΥΨΟΣ ΔΑΒΑΚΗ\u003c/h3\u003e\u003ca href=\"javascript:void(0)\" onclick=\" addPin(\u0027startPin\u0027, 23.707248 , 37.949477  , \u0027Αρχή Διαδρομής\u0027, \u0027/traffic/images/start.png\u0027 ); addPin(\u0027endPin\u0027, 23.736802 , 37.871828 , \u0027Τέλος Διαδρομής\u0027 , \u0027/traffic/images/end.png\u0027); map.moveTo(new telenavis.WorldPoint( 23.702719 , 37.917212  ,4326),12) \" title=\"Προβολή διαδρομής στο χάρτη\" \u003e\u003cli id=\u0027liColor\u0027 class=\u0027green\u0027 runat=\u0027server\u0027\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΈως:\u003c/strong\u003eΓΛΥΦΑΔΑ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ )\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΚατεύθυνση:\u003c/strong\u003eΠΡΟΣ ΓΛΥΦΑΔΑ\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΜήκος:\u003c/strong\u003e11321 χμ.\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΤαχ.:\u003c/strong\u003e71 χμ/ω \u003c/div\u003e \u003cdiv\u003e9 λεπτά \u003c/div\u003e\u003c/li\u003e\u003c/a\u003e \u003ch3 \u003eΑπό: ΥΨΟΣ ΔΑΒΑΚΗ\u003c/h3\u003e\u003ca href=\"javascript:void(0)\" onclick=\" addPin(\u0027startPin\u0027, 23.707248 , 37.949477  , \u0027Αρχή Διαδρομής\u0027, \u0027/traffic/images/start.png\u0027 ); addPin(\u0027endPin\u0027, 23.717512 , 37.906117 , \u0027Τέλος Διαδρομής\u0027 , \u0027/traffic/images/end.png\u0027); map.moveTo(new telenavis.WorldPoint( 23.691574 , 37.925061  ,4326),12) \" title=\"Προβολή διαδρομής στο χάρτη\" \u003e\u003cli id=\u0027liColor\u0027 class=\u0027green\u0027 runat=\u0027server\u0027\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΈως:\u003c/strong\u003eΛ.ΑΛΙΜΟΥ (μέσω Λ.ΠΟΣΕΙΔΩΝΟΣ )\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΚατεύθυνση:\u003c/strong\u003eΠΡΟΣ ΓΛΥΦΑΔΑ\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΜήκος:\u003c/strong\u003e7028 χμ.\u003c/div\u003e\u003cdiv class=\u0027row\u0027\u003e\u003cstrong\u003eΤαχ.:\u003c/strong\u003e71 χμ/ω \u003c/div\u003e \u003cdiv\u003e5 λεπτά \u003c/div\u003e\u003c/li\u003e\u003c/a\u003e\u003c/ul\u003e\u003c/div\u003e"}
EOF
)

road="Λ.ΣΥΓΓΡΟΥ"

echo $raw_data |json_pp |sed 's/Από:/\nΑπό:/g' |sed 's/<\/h3>.*startPin\W//' |sed 's/, \WΑρχή Διαδρομής.*endPin\W//' |sed 's/\WΤέλος .*<strong>Έως:<\/strong>/Έως: /' |sed 's/<\/div>.*Κατεύθυνση:<\/strong>/, /' |sed 's/<\/div>.*Μήκος:<\/strong>/, /' |sed 's/<\/div><div class=\Wrow\W><strong>Ταχ.:<\/strong>/, /' |sed 's/<\/div>.*$//' |grep "Από:" |sed 's/[ ]*,/,/g; s/,[ ]*/,/g' |sed 's/Από: //; s/Έως: //; s/ΠΡΟΣ //; s/ χμ\.//; s/ χμ\/ω//' |sed 's/ )/)/' |sed "s/^/${road},/"

