# configurations
window.Libre = window.Libre || {}
window.Libre._configs = _config =
  properties:
    base: "//midialibre.org"
    api: "//api.midialibre.org/api"
    assets:
      button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
      button_thanks: "/assets/sdk/v1.0/img/lbr-button-image.thanks.svg"


###
# Configuration class
###
module.exports = class

  @all: (environment = 'production') ->
    _config['properties'] || {}

  @getEntry: (key, env = 'production') ->
    _config['properties'][key] || {}

  @env: (environment) ->
    @all environment

