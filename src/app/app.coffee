define [
  'backbone'
  'geoxml3'
  'models/project'
  'collections/projects'
  'views/map'
  'views/filters'
  'views/overlay'
  'views/project'
  'text!/app/map.kml'
], (Backbone, geoXML3, ProjectModel, ProjectsCollection, MapView, FiltersView, OverlayView, ProjectView, kml) ->

  class App

    initialize: ->
      # Create Google Map
      @mapView = new MapView
        el: '#map-canvas'

      # Create collection of projects
      @projects = new ProjectsCollection
      @projects.on 'add', @buildProjectViews, @

      # Initiate filters view and render
      @filtersView = new FiltersView el: '#filters'
      @filtersView.on 'filter', @projects.applyFilters, @projects

      # Parse KML
      app = @
      @kmlParser = new geoXML3.parser
        suppressInfoWindows: true
        afterParse: (doc) ->
          projects = []
          _.each doc[0].placemarks, (placemark) ->
            projects.push new ProjectModel(placemark)

          projects = _.sortBy projects, (project) ->
            if project.get('name').slice(0, 4) == 'The '
              project.get('name').slice(4)
            else
              project.get 'name'

          app.projects.add projects

      @kmlParser.parseKmlString(kml)

    buildProjectViews: (project) ->
      # Setup overlay views for each project
      overlayView = new OverlayView
        model: project
        map:   @mapView.googleMap

      # Setup list view for each project
      projectView = new ProjectView
        model: project

      projectView.on 'zoom', (project) ->
        @mapView.googleMap.fitBounds project.bounds

        if parseInt(@mapView.googleMap.getZoom()) > 17
          @mapView.googleMap.setZoom 17
      , @

      $('#projects').append projectView.render()
