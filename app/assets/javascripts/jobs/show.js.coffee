$(document).ready () ->
  letters = ["B","A"]
  bounds = new google.maps.LatLngBounds

  map = new google.maps.Map(document.getElementById("map"), {
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true
  })

  $('.drop-row').each (i) ->
    point = $(this).data()
    point = new google.maps.LatLng point.lat, point.lng
    bounds.extend point
    new google.maps.Marker
      position: point
      map: map
      icon: "https://chart.googleapis.com/chart?chst=d_map_pin_letter&chld=#{letters.pop()}|000000|ffffff"

  map.fitBounds bounds
