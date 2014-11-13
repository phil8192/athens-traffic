athens-traffic
==============

athens traffic model revised.
follow up project based on traffic forecasting model developed some time ago:
http://entropy.disconnect.me.uk/2011/05/taxi-calculation-reloaded.html

sensor data:
https://github.com/phil8192/athens-traffic/blob/master/data/segments.geojson

average daily speeds:

!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Alexandras-Patision-Katehaki_inside_Alexandras-Katehaki.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Alexandras-Patision-Katehaki_inside_Mesogeion-Katehaki.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Athenon-Geoponikh_School-Attiki_Odos_inside_Kifisou-North.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Athenon-Geoponikh_School-Dafni-Dafni.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Athenon-Thevon-Omonia-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Athenon-Thevon-Sef_junction_inside_Kifisou-Peiraia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/grand_average.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisias-Big_OTE-Hilton-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisias-Big_OTE-Katehaki-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisias-Katehaki-Attiki_Odos-Kifisia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisias-Katehaki-Hilton-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisias-Katehaki-Syntagma_inside_Vasilissis_Sofias-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Allu_Fun_Park-Alimou_inside_Poseidonos-Glyfada.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Allu_Fun_Park-Ippodameias_Square_Peirais_inside_Poseidonos-Peiraia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Iera_Odo-Attiki_Odos-North.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Iera_Odo-Dafni_inside_Athenon-Dafni.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Laxanagora_Centre-Axarnon-North.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Laxanagora_Centre-Lenorman-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Laxanagora_Centre-Omonia_inside_Athenon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Laxanagora_Centre-Omonia_inside_Rally_Square-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Metamorphosi-Athenon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Metamorphosi-Axarnon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Metamorphosi-Dafni_inside_Athenon-Dafni.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Renault-Athenon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Renault-Lenorman-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Renault-Omonia_inside_Athenon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Treis_Gefures-Dafni_inside_Athenon-Dafni.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Treis_Gefures-Omonia_inside_Athenon-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Kifisou-Treis_Gefures-Sef_Junction-Peiraia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Mesogeion-Agia_Paraskevi_Stadium-Katehaki-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Mesogeion-Katehaki-Hilton_inside_Vasilissis_Sofias-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Mesogeion-Katehaki-Stavro_Agia_Paraskevis-Stavro.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Mesogeion-Katehaki-Syntagma_inside_Vasilissis_Sofias-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Peiraios-Xamosternas-Omonia-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Poseidonos-Alimou-Syntagma_inside_Syggrou-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Poseidonos-Before_Sef_Junction-Iera_inside_Kifisou-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Poseidonos-Before_Sef_Junction-Ippodameias_Square_Peiraias-Peiraia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Poseidonos-Boula-Alimou-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Skilitsi_Omiridou-Gepedo_Karaiskaki-Omonia_inside_Poseidonos-kifisou-rally-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Skilitsi_Omiridou-Gepedo_Karaiskaki-Omonia_inside_Poseidonos-Syggrou-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Syggrou-Ypsos_Davaki-Alimou_inside_Poseidonos-Glyfada.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Syggrou-Ypsos_Davaki-Glyfada_inside_Poseidonos-Glyfada.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Syggrou-Ypsos_Davaki-Ippodameias_Square_Peiraias_inside_Poseidonos-Asia_Minor-Peiraia.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Syggrou-Ypsos_Panteiou-Syntagma-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Voulagmenis-Elliniko-Agios_Demitrios_Metro_Station-Centre.png)
!["plot"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/Voulagmenis-Elliniko-Syntagma_inside_Amalias-Centre.png)
