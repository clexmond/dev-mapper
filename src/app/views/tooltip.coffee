define [
  'backbone'
  'text!templates/tooltip.html'
  'async!https://maps.googleapis.com/maps/api/js?key=AIzaSyANs-jbhHBLlA4BqRlGwInv6xiMpcVGTD0&sensor=false'
], (Backbone, template) ->

  class Tooltip extends google.maps.OverlayView

    template: _.template template

    constructor: (options) ->
      super

      # Assign options
      @poly    = options.poly
      @content = options.content
      @map     = options.poly.getMap()

      # Bind to map
      @setMap @map

      # Define event listeners
      tooltip = @
      google.maps.event.addListener tooltip.poly, 'mouseover', (event) ->
        tooltip.show(event.latLng)
      google.maps.event.addListener tooltip.poly, 'mouseout', ->
        tooltip.hide()

    draw: -> # No-op

    hide: ->
      if @div then $(@div).hide()

    onAdd: ->
      @div      = $(@template({ content: @content }))
      panes     = @getPanes()
      floatPane = panes.floatPane
      $(floatPane).append @div

    onRemove: ->
      @div.parentNode.removeChild @div

    show: (latLng) ->
      if @div
        overlayProj = @getProjection()
        position    = overlayProj.fromLatLngToDivPixel latLng

        # Position div and show
        @div.css 'left', (Math.floor(position.x) + 10) + 'px'
        @div.css 'top', Math.floor(position.y) + 'px'
        @div.show()
