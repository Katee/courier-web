# Show a Google Map and asyn load some polylines

$(window).on('resize', () ->
  $("#map").height($(window).height() - $('header.navbar-fixed-top').height()).css({ marginTop: $('header.navbar-fixed-top').height() })
)

$(document).ready(() ->
  $(window).trigger('resize')

  mapOptions = {
    center: new google.maps.LatLng(43.653226,-79.383184)
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
  }
  map = new google.maps.Map(document.getElementById("map"), mapOptions)

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
          strokeOpacity: 1.0
          strokeWeight: 2
        ).setMap(map)
  })

  $.ajax({
    url: '/locations.json'
    success: (data) ->
      $(data).each (v, point) ->
        marker = new google.maps.Marker(
          position: new google.maps.LatLng(point.lat, point.lng)
          map: map
          title: point.name
        )
  })
)
