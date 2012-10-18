# Show a map and asyn load some polylines

# TODO have the courier's have assigned colors
colors = [
  "#ff0000"
  "#0000ff"
  "#af29f5"
]

options = {
  strokeWeight: 6
}

polylineOptions = {
  strokeWeight: 2
  strokeOpacity: .9
}
activePolylineOptions = {
  strokeWeight: 4
  strokeOpacity: .9
}

$(window).on('resize', () ->
  $("#sidebar").height($(window).height() - $('header.navbar-fixed-top').height()).css({ position: "absolute" })
  $("#map").height($(window).height() - $('header.navbar-fixed-top').height()).width($(window).width() - $("#sidebar").outerWidth(true)).css({ marginTop: $('header.navbar-fixed-top').height(), marginLeft: $("#sidebar").outerWidth(true) })
)

$(document).ready () ->
  $(window).trigger 'resize'

  if google != nil
    options.markerRed = new google.maps.MarkerImage('/assets/circle-red.png', new google.maps.Size(10,10), new google.maps.Point(0,0), new google.maps.Point(5,5))
    map = new google.maps.Map document.getElementById("map"), {
      center: new google.maps.LatLng(43.653226,-79.383184)
      zoom: 14
      mapTypeId: google.maps.MapTypeId.ROADMAP
      panControl: false
      scaleControl: true
    }
    infowindow = new google.maps.InfoWindow

    # TODO show the couriers path

    # Show drop locations
    $.ajax
      url: '/jobs.json'
      success: (data) ->
        # make lines
        $.each data.jobs, (id, job) ->
          job.polylines = []
          points = []
          $.each job.drops, (index, drop) ->
            points.push data.locations[drop]
          job.polylines.push new google.maps.Polyline
            path: (new google.maps.LatLng(point.lat, point.lng) for point in points)
            strokeColor: colors[id % colors.length]
            strokeOpacity: polylineOptions.strokeOpacity
            strokeWeight: polylineOptions.strokeWeight
            geodesic: true # doesn't matter for short distances
            zIndex: 2
            map: map
          $.each job.polylines, (index, polyline) ->
            google.maps.event.addListener polyline, 'mouseover', () ->
              $("#sidebar").append("<li><a href=\"/jobs/#{job.id}\">#{job.id}</a></li>")
              polyline.setOptions activePolylineOptions
            google.maps.event.addListener polyline, 'mouseout', () ->
              polyline.setOptions polylineOptions

        # make makers
        $.each data.locations, (id, location) ->
          location.marker = new google.maps.Marker
            position: new google.maps.LatLng(location.lat, location.lng)
            title: "#{location.name}, #{location.address}"
            icon: options.markerRed
            zIndex: 3
            map: map

          # show polylines connected to selected marker
          google.maps.event.addListener location.marker, 'mouseover', () ->
            $("#sidebar").append("<li><a href=\"/locations/#{location.id}\">#{location.name}</a><br />#{location.address}<br />#{location.open_drop_count} open drops</li>")
            $.each data.jobs, (index, job) ->
              if 0 <= $.inArray location.id, job.drops
                (polyline.setOptions activePolylineOptions for polyline in job.polylines)
          google.maps.event.addListener location.marker, 'mouseout', () ->
            $.each data.jobs, (index, job) ->
              if 0 <= $.inArray location.id, job.drops
                (polyline.setOptions polylineOptions for polyline in job.polylines)
    all_location_markers = []
    $.ajax({
      url: '/locations.json'
      success: (data) ->
        all_location_markers = (
         new google.maps.Marker(
            position: new google.maps.LatLng(point.lat, point.lng)
            title: "#{point.id}: #{point.name}, #{point.address}"
            map: map
            icon: '/assets/circle.png'
            zIndex: 1
            visible: $("#all_locations").is(":checked")
          ) for point in data
        )
    })
    $('#all_locations').change () ->
      (marker.setVisible($(this).is(":checked")) for marker in all_location_markers)

