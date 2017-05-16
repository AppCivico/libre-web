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
          /vanillaTextMask.js$/
          /textMaskAddons.js$/
          /store.*.js$/
        ]
        'assets/js/application.bundle.js': [
          /^app(\/|\\)javascripts(\/|\\)/
        ]
        'assets/js/test.bundle.js': [
          /^test(\/|\\)/
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
    nameCleaner: (path) =>
      path.replace(/^app(\/|\\)javascripts(\/|\\)/, '')


  # plugins configurations
  plugins:
    sass:
      debug: 'comments'
      options:
        includePaths: ['node_modules/bootstrap-sass/assets/stylesheets']
        precision: 8



  conventions:
    assets: /^source(\/|\\)assets/


  paths:
    public: ".tmp/dist"
    watched: [
      "app/javascripts"
      "app/stylesheets"
      "app/"
      "test/"
    ]

  watcher:
    awaitWriteFinish: true
    usePolling: true
