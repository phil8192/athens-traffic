#!/bin/bash
#
# 1 year later.... put the harvested data into a single log file.
#
# add filename (time and date) as first column of data.
# example file name: 2014-11-02 21:15:01+02:00.csv
#
# ./raw2csv.sh >/tmp/traffic.log

for i in $(find . -name "*.csv" |sed 's/ /_/; s/\.\///'); do
  cat "$(echo $i |sed 's/_/ /')" \
      |awk -v d="$(echo $i |sed 's/_/ /; s/\+.*.csv//')" '{print d "," $0}'
done

