define [
  'backbone'
  'views/tooltip'
], (Backbone, Tooltip) ->

  class Overlay extends Backbone.View

    applyHoverColor: (hover) ->
      type = if @model.get 'polygon' then 'polygon' else 'polyline'
      poly = if @model.get 'polygon' then @model.get 'polygon' else @model.get 'polyline'

      try
        if type is 'polygon'
          if hover
            poly.setOptions fillColor: @colors.hover
          else
            poly.setOptions fillColor: @colors.base
        else if type is 'polyline'
          if hover
            poly.setOptions strokeColor: @colors.hover
          else
            poly.setOptions strokeColor: @colors.base

    initialize: (options) ->
      @map    = options.map
      @colors =
        base:     '#0000ff'
        selected: '#ff0000'
        hover:    '#00ff00'

      @listenTo @model, 'change', @render
      @listenTo @model, 'hover', @applyHoverColor
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

        # Create tooltip
        @tooltip = new Tooltip
          content: @model.get('name')
          poly:    poly

        # Add event listeners
        google.maps.event.addListener poly, 'click', (event) ->
          model.trigger 'overlayClicked'
      catch error
        return null