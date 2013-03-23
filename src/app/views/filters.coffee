define [
  'backbone'
  'text!templates/filters.html'
], (Backbone, template) ->

  class Filters extends Backbone.View

    events:
      'click li': 'toggleFilter'

    template: _.template template

    initialize: () ->
      @appliedFilters = []
      @render()

    render: () ->
      @$el.html @template()

    toggleFilter: (event) ->
      type = $(event.currentTarget).data 'filter'

      if _.indexOf(@appliedFilters, type) > -1
        @appliedFilters.splice _.indexOf(@appliedFilters, type), 1
      else
        @appliedFilters.push type

      @trigger 'filter', @appliedFilters