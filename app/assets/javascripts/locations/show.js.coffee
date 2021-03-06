$(document).ready(() ->
  point = $('#map').data()
  point = new google.maps.LatLng(point.lat, point.lng)

  mapOptions = {
    center: point
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions)

  marker = new google.maps.Marker(
    position: point
    map: map
    icon: "https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=A|000000|ffffff"
  )
)
