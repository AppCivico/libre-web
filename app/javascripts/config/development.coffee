###
#  Application config class
#  @author dvinciguerra
###
module.exports = Backbone.Config = class Config
  @config =
    # route table
    routes:
      contactPath: (args...) -> "/contact"
      donorPath:  (args...) -> "/register/donor"


    # config for development
    properties:
      name:     "Libre-App"
      api_base: "//hapilibre.eokoe.com/api"
      url_base: "//dev.midialibre.org.br"
      debug:    true


  # getting env config
  @env: =>
    conf = @config['properties']

    # config helpers
    conf.urlFor = conf.url_for = (token) =>
      return @routes[token]

    return conf


