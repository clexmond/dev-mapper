define [
  'backbone'
  'text!templates/filters.html'
], (Backbone, template) ->

  class Filters extends Backbone.View

    events:
      'click li': 'toggleFilter'

    template: _.template template

    initialize: () ->
      @status  = null
      @filters = []
      @render()

    render: () ->
      @$el.html @template()

    toggleFilter: (event) ->
      @status = $(event.currentTarget).data('status') || @status
      @filters = []

      # if _.indexOf(@appliedFilters, type) > -1
      #   @appliedFilters.splice _.indexOf(@appliedFilters, type), 1
      # else
      #   @appliedFilters.push type

      # Update styles
      @$el.find('li').removeClass 'selected'
      $(event.currentTarget).addClass 'selected'

      # Trigger event to allow map filtering
      @trigger 'filter', @status, @filters