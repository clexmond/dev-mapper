define [
  'backbone'
  'views/project'
  'text!templates/projects.html'
], (Backbone, ProjectView, template) ->

  class Projects extends Backbone.View

    template: _.template template

    render: ->
      @$el.html @template()
      @renderSubViews()

    renderSubViews: ->
      _.each @collection, (project, key) ->
        projectView = new ProjectView model: project
        @$el.find('#projects').append projectView.render()
      , @