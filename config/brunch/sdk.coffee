# See http://brunch.io for documentation.

module.exports =
  overrides:
    production:
      optimize: true
      sourceMaps: true

  # add assets configurations
  files:
    javascripts:
      joinTo:
        'sdk/libre.js': /^sdk(\/|\\)/

  # modules configurations
  modules:
    nameCleaner: (path) =>
      path.replace(/^sdk(\/|\\)javascripts(\/|\\)/, '')
    autoRequire:
      'sdk/libre.js': ['libre.js']


  # plugins configurations
  plugins:
    babel:
      presets: ['latest']


  paths:
    public: ".tmp/dist"
    watched: [
      "sdk/javascripts"
    ]

  watcher:
    awaitWriteFinish: true
    usePolling: true
