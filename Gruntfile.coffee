module.exports = (grunt) ->

  # Project config
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')
    coffee:
      compile:
        expand: true
        cwd: 'src/app/'
        src: [ '**/*.coffee' ]
        dest: 'build/app/'
        ext: '.js'
    copy:
      libs:
        expand: true
        cwd: 'src/lib'
        src: [ '**' ]
        dest: 'build/lib/'
      css:
        expand: true
        cwd: 'src/styles'
        src: [ '**' ]
        dest: 'build/styles'
      templates:
        expand: true
        cwd: 'src/app/templates'
        src: [ '**' ]
        dest: 'build/app/templates'
      main:
        files: [
          { src: 'src/map.html', dest: 'build/map.html' }
          { src: 'src/app/map.kml', dest: 'build/app/map.kml' }
          { src: 'src/favicon.ico', dest: 'build/favicon.ico' }
          { expand: true, cwd: 'src/images', src: [ '**' ], dest: 'build/images' }
        ]
    watch:
      scripts:
        files: 'src/app/**/*.coffee'
        tasks: [ 'coffee:compile' ]
      css:
        files: 'src/styles/**/*.css'
        tasks: [ 'copy:css' ]
      templates:
        files: 'src/app/templates/**/*.html'
        tasks: [ 'copy:templates' ]
      main:
        files: 'src/map.html'
        tasks: [ 'copy:main' ]

  # Load plugins
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  # Register tasks
  grunt.registerTask 'build', [ 'copy', 'coffee:compile' ]