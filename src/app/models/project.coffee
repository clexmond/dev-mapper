define [
  'backbone'
], (Backbone) ->

  class Project extends Backbone.Model

    initialize: (placemark) ->
      try
        attributes = JSON.parse $(placemark.description).text()
      catch error
        attributes = {}
      finally
        @set attributes
        @set filtered: false