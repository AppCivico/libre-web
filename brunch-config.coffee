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
        'assets/js/vendor.bundle.js': /^(?!app(\/|\\)javascripts(\/|\\))/
        'assets/js/application.bundle.js': /^app(\/|\\)javascripts(\/|\\)/
        'assets/js/test.bundle.js': /^test(\/|\\).*\.coffee/

    stylesheets:
      joinTo:
        'assets/css/application.bundle.css': /^app(\/|\\)stylesheets(\/|\\)/

    templates:
      joinTo:
        'assets/js/application.bundle.js': /^app(\/|\\)javascripts(\/|\\)templates(\/|\\)/


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

  # modules configurations
  modules:
    nameCleaner: (path) =>
      path.replace(/^app(\/|\\)javascripts(\/|\\)/, '')


  # plugins configurations
  #plugins:

  conventions:
    assets: /^source(\/|\\)assets/

  paths:
    public: ".tmp/dist"
    watched: [
      "app/javascripts"
      "app/stylesheets"
      "test/"
      "app/"
    ]

