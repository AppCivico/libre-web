# configurations
window.Libre = window.Libre || {}
window.Libre._configs =
  development:
    base: "//devlibre.eokoe.com"
    assets:
      button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
      button_thanks: "/assets/sdk/v1.0/img/lbr-button-image.thanks.svg"

  production:
    base: "//devlibre.eokoe.com"
    assets:
      button: "/assets/sdk/v1.0/img/lbr-button-image.svg"
      button_thanks: "/assets/sdk/v1.0/img/lbr-button-image.thanks.svg"



###
# Configuration class
###
module.exports = class Config
  @getEntry: (key, env = 'production') ->
    window.Libre._configs[env][key] || {}


  @env: (name = 'production') ->
    @getEntry(name)


