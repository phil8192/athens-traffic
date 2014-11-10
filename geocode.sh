#!/bin/bash
# geocoding pre-processing.
#
# there are 45 road segments in the data.
# each road segment is defined with a pair of starting and ending latitudes and 
# longitudes. this script uses these from,to coordinates to determine an 
# on-road linestring. this is done by querying mapquest's directions api:
# http://developer.mapquest.com/web/products/dev-services/directions-ws
# each query returns json data from which linestring coordinate pairs are 
# extracted.
#
# ./geocode >data/linestrings.log

key=$(cat mapquest-developer.key)
url="http://open.mapquestapi.com/directions/v1/route?key=$key&narrativeType=text&enhancedNarrative=false&outFormat=json&routeType=fastest&shapeFormat=raw&generalize=10&locale=en_US&unit=k"

for i in $(tail -n+2 data/csv/road-segments.csv |awk -F ',' '{print "&from=" $7 "," $8 ",&to=" $9 "," $10}'); do
  curl -s "$url$i" |sed 's/^.*shapePoints\"://; s/,\".*$/\n/'
done

