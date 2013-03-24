define [
  'backbone'
], (Backbone) ->

  class Project extends Backbone.Model

    initialize: (placemark) ->
      try
        attributes = JSON.parse $(placemark.description).text()
      catch error
        attributes = {}
      finally
        @set attributes
        @set filtered: false

      poly    = if placemark.polygon then placemark.polygon else placemark.polyline
      @bounds = @getBounds poly

    getBounds: (poly) ->
      bounds = new google.maps.LatLngBounds()
      poly.getPath().forEach (element, index) ->
          bounds.extend element

      return bounds