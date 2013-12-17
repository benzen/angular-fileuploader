module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    clean: ['bower_components','js', 'dist', 'lib','example/css','example/font', 'example/js']

    bower:
      install:
        options:
          install: true

    coffee:
      compile:
        files:
          'js/angular-fileuploader.js': ['src/**/*.coffee']
        options:
          bare: true
          sourceMap: false

    concat:
      js:
        src: [ 'src/angular-fileuploader.js' ]
        dest: 'dist/angular-fileuploader.js'

    uglify:
      options:
        mangle: false
      main:
        files:
          'dist/angular-fileuploader.min.js': ['dist/angular-fileuploader.js']

    watch:
      options:
        livereload: true
        spawn: false
        debounceDelay: 50
        atBegin: true
      coffee:
        files: 'src/**/*.coffee'
        tasks: ['coffee:compile', 'concat', 'uglify:main']

    karma:
      'watch-unit':
        configFile: 'build/karma.conf.js'
        autoWatch: true
      'watch-e2e':
        configFile: 'build/karma-e2e.conf.js'
        autoWatch: true
      unit:
        configFile: 'build/karma.conf.js'
        singleRun: true
        browsers: ['PhantomJS']
      e2e:
        configFile: 'build/karma-e2e.conf.js'
        singleRun: true
        browsers: ['PhantomJS']
      everything:
        configFile: 'build/karma-e2e.conf.js'
        singleRun: true
        browsers: ['PhantomJS', 'Firefox', 'Chrome']

    # copy files to exemple directory
    copy:
      js:
        files: [ flatten:true, expand:true, src: [
          'lib/bootstrap/bootstrap.js',
          'lib/angular/angular.js',
          'lib/jquery/jquery.js'
        ], dest: 'example/js' ]
      css:
        files: [ flatten:true, expand:true, src: [
          'lib/font-awesome/css/*.css'
          'lib/bootstrap/*.css'
        ], dest: 'example/css' ]
      font:
        files: [ flatten:true, expand:true, src: [ 'lib/font-awesome/fonts/*' ], dest: 'example/fonts/' ]

    'http-server':
        dev:
        #  the server root directory
          root: "./"
          port: 8000,
          host: "localhost"
          # cache: "<sec>"
          showDir : true,
          autoIndex: true,
          defaultExt: "html",
          #wait or not for the process to finish
          runInBackground: true

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-karma'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-http-server'

  grunt.registerTask 'test-unit', ['karma:unit']
  grunt.registerTask 'test-system', ['http-server','karma:e2e']

  grunt.registerTask 'default', [ 'clean', 'bower','coffee', 'concat', 'uglify', 'copy:*','test-unit', 'test-system' ]

