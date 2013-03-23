define [
  'backbone'
  'text!templates/project.html'
], (Backbone, template) ->

  class Project extends Backbone.View

    tagName:  'li'
    template: _.template template

    render: ->
      @$el.html @template(@model.attributes)
