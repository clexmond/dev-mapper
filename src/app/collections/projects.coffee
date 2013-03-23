define [
  'backbone'
], (Backbone) ->

  class Projects extends Backbone.Collection

    applyFilters: (filters) ->
      _.each @models, (project) ->
        console.log project
        if project.get 'tags'
          project.set filtered: true
        else
          project.set filtered: false
