# configurations
window.Libre = window.Libre || {}
window.Libre._configs =
  development:
    base: "//dev.midialibre.org"
    assets:
      button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
      button_thanks: "/assets/sdk/v1.0/img/lbr-button-image.thanks.svg"

  production:
    base: "//dev.midialibre.org"
    assets:
      button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
      button_thanks: "/assets/sdk/v1.0/img/lbr-button-image.thanks.svg"



###
# Configuration class
###
module.exports = class Config

  @all: (name = 'production')->
    (window.Libre._configs[name]) ? {}

  @getEntry: (key, env = 'production') ->
    window.Libre._configs[env][key] || {}

  @env: (name = 'production') ->
    @getEntry(name)

