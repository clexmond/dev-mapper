define [
  'backbone'
], (Backbone) ->

  class Overlay extends Backbone.View

    initialize: (options) ->
      @map    = options.map
      @colors =
        base:     '#000000'
        selected: '#0000ff'

      @listenTo @model, 'change', @render
      @render()

    render: ->
      type = if @model.get 'polygon' then 'polygon' else 'polyline'
      poly = if @model.get 'polygon' then @model.get 'polygon' else @model.get 'polyline'

      try
        if type is 'polygon'
          if @model.get('filtered') is true
            poly.setOptions fillColor: @colors.selected
          else
            poly.setOptions fillColor: @colors.base
        else if type is 'polyline'
          if @model.get('filtered') is true
            poly.setOptions strokeColor: @colors.selected
          else
            poly.setOptions strokeColor: @colors.base

        poly.setMap @map
        model = @model
        google.maps.event.addListener poly, 'click', (event) ->
          window.open model.get('url'), '_blank'
      catch error
        return null