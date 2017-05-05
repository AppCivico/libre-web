# See docs at http://brunch.readthedocs.org/en/latest/config.html.

exports.config =
  overrides:
    production:
      optimize: true
      sourceMaps: true
      paths:
        public: ".tmp/dist"

  # add assets configurations
  files:
    javascripts:
      joinTo:
        'assets/js/vendor.bundle.js': [
          /jquery.js$/
          /undebackbone.js$/
          /backbone.js$/
          /backbone.marionette.js$/
          /backbone.radio.js$/
          /underscore.js$/
          /rails.js$/
        ]
        'assets/js/application.bundle.js': [
          /^app(\/|\\)javascripts(\/|\\)/
        ]
        'assets/js/test.bundle.js': [
          /^test(\/|\\)specs(\/|\\).*\.coffee/
          /test_helpers.coffee$/
        ]

    stylesheets:
      joinTo: 'assets/css/application.bundle.css'
      order:
        after: /^app(\/|\\)stylesheets(\/|\\)/

    templates:
      joinTo:
        'assets/js/application.bundle.js': [
          /\.eco$/
        ]


  # npm integration
  npm:
    enabled: true,
    styles:
      bootstrap: ['dist/css/bootstrap.css']
    globals:
      '$': 'jquery'
      'jQuery': 'jquery'
      '_': 'underscore'
      'Backbone': 'backbone'
      'Marionette': 'backbone.marionette'
      'jquery-ujs': 'jquery-ujs'
      'bootstrap': 'bootstrap-sass',

  # modules configurations
  modules:
    nameCleaner: (path) =>
      path.replace(/^app(\/|\\)javascripts(\/|\\)/, '')


  # plugins configurations
  plugins:
    sass:
      options:
        includePaths: ["node_modules/bootstrap-sass/assets/stylesheets"]
        precision: 8


  conventions:
    assets: /^source(\/|\\)assets/
    ignored: /^node_modules/


  paths:
    public: ".tmp/dist"
    watched: [
      "app/javascripts"
      "app/stylesheets"
      "test/"
      "app/"
    ]

