# Show a Google Map and asyn load some polylines

$(document).ready(() ->
  mapOptions = {
    center: new google.maps.LatLng(43.653226,-79.383184)
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions)

  $.ajax({
    url: '/location_update.json'
    success: (data) ->
      colors = [
        "#ff0000"
        "#00ff00"
        "#0000ff"
      ]

      $.each data, (key, list) ->
        new google.maps.Polyline(
          path: (new google.maps.LatLng(point.lat, point.lng) for point in list)
          strokeColor: colors.pop()
          strokeOpacity: 1.0
          strokeWeight: 2
        ).setMap(map)
  })
)
