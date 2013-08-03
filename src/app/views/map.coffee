define [
  'backbone'
  'geoxml3'
  'text!/app/map.kml'
  'views/project'
  'views/overlay'
  'async!https://maps.googleapis.com/maps/api/js?key=AIzaSyANs-jbhHBLlA4BqRlGwInv6xiMpcVGTD0&sensor=false'
], (Backbone, geoXML3, kml, ProjectView, OverlayView) ->

  class Map extends Backbone.View

    styles: [
      {
        elementType: "geometry"
        stylers: [
          { saturation: -100 }
          { visibility: "simplified" }
        ]
      },{
        elementType: "labels.icon",
        stylers: [
          { hue: "#0011ff" },
          { visibility: "on" },
          { weight: 0.1 },
          { saturation: -50 }
        ]
      },{
        featureType: "administrative",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "road",
        stylers: [
          { weight: 1.5 }
        ]
      },{
        elementType: "labels.text",
        stylers: [
          { weight: 0.1 }
        ]
      },{
        featureType: "poi",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "landscape",
        elementType: "labels",
        stylers: [
          { visibility: "off" }
        ]
      },{
        featureType: "poi.park",
        elementType: "geometry",
        stylers: [
          { hue: "#c3ff00" },
          { saturation: 27 }
        ]
      },{
        featureType: "water",
        elementType: "geometry",
        stylers: [
          { hue: "#004cff" },
          { saturation: 16 }
        ]
      }
    ]

    initialize: ->
      @render()

    render: ->
      @googleMap = new google.maps.Map @el,
        center:    new google.maps.LatLng(33.7489, -84.3881)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        styles:    @styles
        zoom:      12
        