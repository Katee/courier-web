# Show a map and asyn load some polylines

$(window).on('resize', () ->
  $("#map").height($(window).height() - $('header.navbar-fixed-top').height()).css({ marginTop: $('header.navbar-fixed-top').height() })
)

$(document).ready(() ->
  $(window).trigger('resize')

  map = new google.maps.Map document.getElementById("map"), {
    center: new google.maps.LatLng(43.653226,-79.383184)
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
    panControl: false
    scaleControl: true
  }

  # Show the path of couriers
  $.ajax({
    url: '/location_update.json'
    success: (data) ->
      # TODO have the courier's have assigned colors
      colors = [
        "#ff0000"
        "#00ff00"
      ]

      $.each data, (key, list) ->
        new google.maps.Polyline(
          path: (new google.maps.LatLng(point.lat, point.lng) for point in list)
          strokeColor: colors.pop()
          strokeOpacity: 0.8
          strokeWeight: 3
          map: map
        )
  })

  infowindow = new google.maps.InfoWindow

  # Show drop locations
  $.ajax({
    url: '/locations.json'
    success: (data) ->
      $(data).each (v, point) ->
        marker = new google.maps.Marker(
          position: new google.maps.LatLng(point.lat, point.lng)
          title: "#{point.name}, #{point.address}"
          map: map
          icon: '/circle.png'
        )
        google.maps.event.addListener(marker, 'click', () ->
          infowindow.close()
          infowindow.setContent("<a href=\"/locations/#{point.id}\">#{point.name}</a><br />#{point.address}")
          infowindow.open(map,marker)
        )
  })
)
