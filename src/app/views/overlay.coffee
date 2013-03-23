define [
  'backbone'
], (Backbone) ->

  class Overlay extends Backbone.View

    initialize: (options) ->
      @map = options.map
      @listenTo @model, 'change', @render
      @render()

    render: () ->
      type = if @model.get 'polygon' then 'polygon' else 'polyline'
      poly = if @model.get 'polygon' then @model.get 'polygon' else @model.get 'polyline'

      try
        if type is 'polygon'
          if @model.get('filtered') is true
            poly.setOptions fillColor: '#00ff00'
          else
            poly.setOptions fillColor: '#0000ff'
        else if type is 'polyline'
          if @model.get('filtered') is true
            poly.setOptions strokeColor: '#00ff00'
          else
            poly.setOptions strokeColor: '#0000ff'

        poly.setMap @map
        view = @
        google.maps.event.addListener poly, 'click', (event) ->
          view.trigger 'click', view.model
      catch error
        return null