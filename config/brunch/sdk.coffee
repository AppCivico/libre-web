# See http://brunch.io for documentation.

module.exports =
  overrides:
    production:
      optimize: false
      sourceMaps: true

  # add assets configurations
  files:
    javascripts:
      joinTo:
        'sdk/libre.js': [
          /json3/
          /^sdk(\/|\\)javascripts(\/||\\)libre.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)config.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)utils.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)renderer.coffee/
        ]
        'sdk/v1/button.js': [
          /fetch-ie8/
          /promise-polyfill/
          /url-search-params/
          /^sdk(\/|\\)javascripts(\/||\\)config.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)v1(\/||\\)button.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)data(\/||\\)guid.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)utils.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)view.coffee/
          /^sdk(\/|\\)javascripts(\/||\\)lib(\/||\\)session.coffee/
        ]

  npm:
    enabled: true
    whitelist: [
      'json3'
      'fetch-ie8'
      'promise-polyfill'
      'url-search-params'
    ]


  # modules configurations
  modules:
    nameCleaner: (path) ->
      path.replace(/^sdk(\/|\\)javascripts(\/|\\)/, '')

    autoRequire:
      'sdk/libre.js': ['libre.coffee']
      'sdk/v1/button.js': ['v1/button.coffee']


  # plugins configurations
  plugins:
    babel:
      presets: ['babel-polyfill','latest']

    eslint:
      pattern: /^sdk\/.*\.js?$/
      warnOnly: true
      config:
        extends: ["eslint:recommended"]

  paths:
    public: ".tmp/dist"
    watched: [
      "sdk/"
    ]

  watcher:
    awaitWriteFinish: true
    usePolling: true
