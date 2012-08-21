# Show a Google Map and asyn load some polylines

$(window).on('resize', () ->
  $("#map").height($(window).height())
  # Center the overmap content vertically
  $(".overmap-content").css({top: $('.navbar-fixed-top').outerHeight() + (($(window).height() - $('.navbar-fixed-top').outerHeight()) / 2), marginTop: -($('.overmap-content').outerHeight() / 2)})
)

$(document).ready(() ->
  $(window).trigger('resize')

  map = new google.maps.Map document.getElementById("map"), {
    center: new google.maps.LatLng(43.653226,-79.383184)
    zoom: 14
    mapTypeId: google.maps.MapTypeId.ROADMAP
    disableDefaultUI: true
  }

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
