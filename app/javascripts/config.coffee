###
#  Application config class
#  @author dvinciguerra
###
module.exports = Backbone.Config = class Config
  # default env
  @environment = 'development'

  @config =
    # route table
    routes:
      contactPath: (args...) -> "/contact"
      donorPath:  (args...) -> "/register/donor"


    # config for development
    development:
      name:     "Libre-App"
      api_base: "//hapilibre.eokoe.com/api"
      url_base: "//dev.midialibre.org"
      debug:    true


    # config for production
    production:
      name:     "Libre-App"
      api_base: "//api.midialibre.org/api"
      url_base: "//midialibre.org"
      debug:    false


  # getting env config
  @env: =>
    conf = @config[@environment || 'production']

    # config helpers
    conf.urlFor = conf.url_for = (token) =>
      return @routes[token]

    return conf


