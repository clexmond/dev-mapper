define [
  'backbone'
  'text!templates/project.html'
], (Backbone, template) ->

  class Project extends Backbone.View

    events:
      'click span': 'handleClick'
      'mouseenter': 'toggleHover'
      'mouseleave': 'toggleHover'

    tagName:  'li'
    template: _.template template

    handleClick: (event) ->
      if @clicked
        @clicked = false
        @$el.find('.project-info').slideUp()
        @$el.removeClass 'clicked'
      else
        @clicked = true
        projectView = @
        @$el.addClass 'clicked'

        if $.trim(@$el.find('.project-info').html()).length > 0
          @$el.find('.project-info').slideDown 'default', ->
            projectView.trigger 'zoom', projectView.model
        else
          projectView.trigger 'zoom', projectView.model

    highlight: ->
      if @model.get 'filtered'
        @$el.addClass 'selected'
      else
        @$el.removeClass 'selected'

    initialize: ->
      @clicked = false
      @hover   = false
      @listenTo @model, 'change', @highlight
      @listenTo @model, 'overlayClicked', @openProject

    openProject: ->
      @clicked = true
      @$el.addClass 'clicked'
      projectView      = @
      console.log $('#map-controls').scrollTop(), @$el.offset().top
      scrollToPosition = $('#map-controls').scrollTop() + @$el.offset().top - 35
      $('#map-controls').animate scrollTop: scrollToPosition, 800, ->
        if $.trim(projectView.$el.find('.project-info').html()).length > 0
          projectView.$el.find('.project-info').slideDown()

    render: ->
      if @model.get 'filtered'
        @$el.addClass 'selected'
      else
        @$el.removeClass 'selected'

      @$el.html @template(@model.attributes)

    toggleHover: (event) ->
      if @hover
        @hover = false
        @model.trigger 'hover', false
      else
        @hover = true
        @model.trigger 'hover', true