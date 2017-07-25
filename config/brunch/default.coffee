# See http://brunch.io for documentation.
env = (process.env.NODE_ENV) || 'production'
console.log "### Running in #{env} MODE"

module.exports =
  overrides:
    production:
      optimize: true
      sourceMaps: true

  # notifications config
  notifications: false

  # add assets configurations
  files:
    javascripts:
      joinTo:
        'assets/js/vendor.bundle.js': [
          /^node_modules/
        ]
        'assets/js/application.bundle.js': [
          /^node_modules/
          /^app(\/|\\)javascripts(\/|\\)pages/
          /^app(\/|\\)javascripts(\/|\\)lib/
          /^app(\/|\\)javascripts(\/|\\)templates/
          /^app(\/|\\)javascripts(\/|\\)modules/
          /^app(\/|\\)javascripts(\/|\\)routes/
          /^app(\/|\\)javascripts(\/|\\)views/
          /^app(\/|\\)javascripts(\/|\\)models/
          (new RegExp "^app/javascripts/config/#{env}\.coffee")
          /^app(\/|\\)javascripts(\/|\\)config.coffee/
          /^app(\/|\\)javascripts(\/|\\)application.coffee/
        ]
        'assets/js/test.bundle.js': [
          /^app(\/||\\)tests(\/|\\)spec_helpers.coffee/
          /^app(\/||\\)tests(\/|\\)specs(\/|\\)[views|models|pages|routes|modules|lib]/
        ]

    stylesheets:
      joinTo:
        'assets/css/application.bundle.css': [
          /^app(\/|\\)stylesheets(\/|\\)/
        ]

    templates:
      joinTo:
        'assets/js/application.bundle.js': [
          /\.eco$/
        ]


  # npm integration
  npm:
    enabled: true
    globals:
      '$': 'jquery'
      'jQuery': 'jquery'
      '_': 'underscore'
      'Backbone': 'backbone'
      'Marionette': 'backbone.marionette'
      'Backbone.Radio': 'backbone.radio'
      'jquery-ujs': 'jquery-ujs'
      'store': 'store'
      'application': 'application.coffee'
    whitelist: [
      'jquery'
      'underscore'
      'backbone'
      'backbone.marionette'
      'jquery-ujs'
      'bootstrap-sass'
      'backbone.radio'
      'vanilla-text-mask'
      'text-mask-addons'
      'store'
      'mocha'
      'chai'
    ]

  # modules configurations
  modules:
    nameCleaner: (path) ->
      path.replace(/^app(\/|\\)javascripts(\/|\\)/, '')

  # plugins configurations
  plugins:
    sass:
      debug: 'comments'
      options:
        includePaths: ['node_modules/bootstrap-sass/assets/stylesheets']
        precision: 8

    babel:
      presets: ['env']

    coffeelint:
      pattern: /^app\/.*\.coffee$/
      useCoffeelintJson: yes

    eslint:
      pattern: /^app\/.*\.js?$/
      warnOnly: true
      config:
        extends: ["eslint:recommended"]




  conventions:
    assets: /^source(\/|\\)assets/


  paths:
    public: ".tmp/dist"
    watched: [
      "app/"
      "test/"
    ]

  watcher:
    awaitWriteFinish: true
    usePolling: true
