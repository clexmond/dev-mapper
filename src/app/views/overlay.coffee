define [
  'backbone'
], (Backbone) ->

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
        google.maps.event.addListener poly, 'click', (event) ->
          window.open model.get('url'), '_blank'
      catch error
        return null