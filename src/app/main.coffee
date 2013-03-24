requirejs.config
  baseUrl: 'lib'
  paths:
    models:      '/app/models'
    collections: '/app/collections'
    views:       '/app/views'
    templates:   '/app/templates'
    app:         '/app/app'

  shim:
    backbone:
      deps:    [ 'underscore', 'jquery' ]
      exports: 'Backbone'

require [ 'app' ], (App) ->
  app = new App
  app.initialize()