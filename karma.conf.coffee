# Karma configuration

module.exports = (config) ->
  config.set

    # base path, that will be used to resolve all patterns, eg. files, exclude
    basePath: ''

    preprocessors:
      '**/*.coffee': ['coffee']

    # options passed to the coffee compiler
    coffeePreprocessor:
      options:
        bare: true
        sourceMap: true

    # frameworks to use
    frameworks: ['mocha', 'chai']

    # list of files / patterns to load in the browser
    files: [
      '.tmp/dist/assets/js/vendor.bundle.js'
      '.tmp/dist/assets/js/application.bundle.js'
      '.tmp/dist/assets/js/test.bundle.js'
      'test/runner.js'
      #'test/**/*.spec.coffee'
    ]


    # list of files to exclude
    exclude: []

    # test results reporter to use
    # possible values: 'dots', 'progress', 'junit', 'growl', 'coverage'
    reporters: ['nyan']

    # web server port
    port: 9876

    # enable / disable colors in the output (reporters and logs)
    colors: true

    # level of logging
    # possible values: config.LOG_DISABLE || config.LOG_ERROR || config.LOG_WARN || config.LOG_INFO || config.LOG_DEBUG
    logLevel: config.LOG_INFO

    # enable / disable watching file and executing tests whenever any file changes
    autoWatch: true

    # Start these browsers, currently available:
    # - Chrome
    # - ChromeCanary
    # - Firefox
    # - Opera
    # - Safari (only Mac)
    # - PhantomJS
    # - IE (only Windows)
    browsers: ['PhantomJS']
    #browsers: ['PhantomJS'] #['Chrome', 'Firefox', 'PhantomJS']

    # If browser does not capture in given timeout [ms], kill it
    captureTimeout: 60000

    # Continuous Integration mode
    # if true, it capture browsers, run tests and exit
    singleRun: false

