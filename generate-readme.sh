#!/bin/bash

cat << EOF
athens-traffic
==============

athens traffic model revised.
follow up project based on traffic forecasting model developed some time ago:
http://entropy.disconnect.me.uk/2011/05/taxi-calculation-reloaded.html

sensor data:
https://github.com/phil8192/athens-traffic/blob/master/data/segments.geojson

average daily speeds:

EOF

for i in $(ls plots); do
  echo "![\"plot\"](https://raw.githubusercontent.com/phil8192/athens-traffic/master/plots/"$i")"
done

