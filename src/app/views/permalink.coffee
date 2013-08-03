define [
  'backbone'
  'text!templates/permalink.html'
], (Backbone, template) ->

  class Permalink extends Backbone.View

    events:
      'click img': 'togglePermalink'

    template: _.template template

    initialize: (options) ->
      @map = options.map
      @render()

    render: () ->
      @$el.html @template()

    togglePermalink: () ->
      lat  = @map.getCenter().lat()
      lng  = @map.getCenter().lng()
      zoom = @map.getZoom()
      url  = "#{window.location.href}?lat=#{lat}&lng=#{lng}&zoom=#{zoom}"

      if @shown
        @$('input').hide()
        @shown = false
      else
        @$('input').val url
        @$('input').show()
        @shown = true
