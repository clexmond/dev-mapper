define [
  'backbone'
], (Backbone) ->

  class Projects extends Backbone.Collection

    applyFilters: (status, filters) ->
      _.each @models, (project) ->

        if status is project.get 'status'
          project.set filtered: true
        else
          project.set filtered: false

    comparator: (project) ->
      project.get 'name'