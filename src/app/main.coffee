requirejs.config
  baseUrl: 'lib'
  paths:
    models:      '/app/models'
    collections: '/app/collections'
    views:       '/app/views'
    templates:   '/app/templates'

  shim:
    backbone:
      deps:    [ 'underscore', 'jquery' ]
      exports: 'Backbone'

require [
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

  # Create Google Map
  mapView = new MapView
    el: '#map-canvas'

  # Create collection of projects
  projects = new ProjectsCollection
  projects.on 'add', (project) ->
    overlayView = new OverlayView
      model: project
      map:   mapView.googleMap

    overlayView.on 'click', (project) ->
      window.open project.get('url'), '_blank'

    projectView = new ProjectView
      model: project

    $('#projects').append projectView.render()

  # Initiate filters view and render
  filtersView = new FiltersView
    el: '#filters'

  filtersView.on 'filter', (filters) ->
    projects.applyFilters filters

  # Parse KML
  kmlParser = new geoXML3.parser
    suppressInfoWindows: true
    afterParse: (doc) ->
      _.each doc[0].placemarks, (placemark) ->
        projects.add new ProjectModel placemark

  kmlParser.parseKmlString(kml)