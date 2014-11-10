#!/bin/bash
# take the automatically created linestrings for each road segment and dump
# them into a google map to check they look ok.
#
# ./check-geocode.sh >/tmp/lala.html

cat << EOF

<!DOCTYPE html>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>test linestrings</title>
    <style>
      html, body, #map-canvas {
        height: 100%;
        margin: 0px;
        padding: 0px
      }
    </style>
    <script src="https://maps.googleapis.com/maps/api/js?v=3.exp"></script>
    <script>

segments=[
EOF

# dump them into segments matrix
cat data/linestrings.log |sed 's/$/,/' |tr -d '\n' |sed 's/,$//'

cat << EOF
];

// get a polyline from the coordinates
function toPolyLine(coords) {
  var latLngs = [];
  for(var i=0, len=coords.length; i<len; i+=2)
    latLngs.push(new google.maps.LatLng(coords[i], coords[i+1]));
  return new google.maps.Polyline({
    path: latLngs, 
    geodesic: true,
    strokeColor: '#FF0000',
    strokeOpacity: 1.0,
    strokeWeight: 5
  });
}

function initialize() {
  var mapOptions = {
    zoom: 12,
    center: new google.maps.LatLng(37.984335, 23.72793),
  };

  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  // add them all to the map
  for(var i=0, len=segments.length; i<len; i++) {
    console.log("adding segment " + i + " of " + len); 
    var segment_linestring = toPolyLine(segments[i]);
    segment_linestring.setMap(map);
  }
}

google.maps.event.addDomListener(window, 'load', initialize);

    </script>
  </head>
  <body>
    <div id="map-canvas"></div>
  </body>
</html>

EOF

