#!/bin/bash
# extracted linestrings to geojson format.
# ./to-geojson.sh > data/segments.geojson

features() {
  local j=2
  for i in $(cat data/linestrings.log |sed 's/,$//g; s/^\[//; s/\]$//g') ;do
    echo "{\"type\": \"Feature\", \"geometry\": {\"type\": \"LineString\", \"coordinates\": ["
    echo $i |sed 's/,$//g; s/^\[//; s/\]$//g' |sed 's/,3/\n3/g' |awk -F ',' '{print $2 "," $1}' |sed 's/^/[/; s/$/],/' |tr -d "\n" |sed 's/,$//'
    echo "]},"
    echo "\"properties\": {"
    tail -n+$j data/csv/road-segments.csv |head -1 |awk -F ',' '{print "\"id\": " $1 ", \"route\": \"" $2 "\", \"from\": \"" $3 "\", \"to\": \"" $4 "\", \"direction\": \"" $5 "\", \"length\": " $6}'
    echo "}},"
    let j++
  done
}

spit_it_out() {
  echo -n "{\"type\": \"FeatureCollection\", \"features\": ["
  features |tr -d "\n" |sed 's/,$//'
  echo "]}"
}

spit_it_out |json_pp

