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
      @$el.find('li').removeClass 'selected'

      if @status is $(event.currentTarget).data('status')
        @status = null
      else
        @status = $(event.currentTarget).data('status') || @status
        $(event.currentTarget).addClass 'selected'

      # Trigger event to allow map filtering
      @trigger 'filter', @status, @filters

      # @filters = []

      # if _.indexOf(@appliedFilters, type) > -1
      #   @appliedFilters.splice _.indexOf(@appliedFilters, type), 1
      # else
      #   @appliedFilters.push type