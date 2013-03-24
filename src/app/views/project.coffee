define [
  'backbone'
  'text!templates/project.html'
], (Backbone, template) ->

  class Project extends Backbone.View

    events:
      'click span': 'handleClick'

    tagName:  'li'
    template: _.template template

    handleClick: (event) ->
      if @clicked
        @clicked = false
        @$el.find('.project-info').slideUp()
        @$el.find('span').removeClass 'clicked'
      else
        @clicked = true
        projectView = @
        @$el.find('span').addClass 'clicked'
        @$el.find('.project-info').slideDown 'default', ->
          projectView.trigger 'zoom', projectView.model

    initialize: ->
      @clicked = false
      @listenTo @model, 'change', @render

    render: ->
      if @model.get 'filtered'
        @$el.addClass 'selected'
      else
        @$el.removeClass 'selected'

      @$el.html @template(@model.attributes)