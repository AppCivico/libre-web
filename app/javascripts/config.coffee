"use strict"


module.exports = class Config
  # default env
  @environment = 'development'

  @config =
    # route table
    routes:
      contactPath: (args...) => "/contact"
      donorPath:  (args...) => "/register/donor"


    # config for development
    development:
      name:     "Libre-App"
      api_base: "//hapilibre.eokoe.com/api"
      debug:    true


    # config for production
    production:
      name:     "Libre-App"
      api_base: "//hapilibre.eokoe.com/api"
      debug:    false


  # getting env config
  @env: =>
    conf = if @environment is 'production' then @config.production else @config.development
    conf.url_for = (token) => @routes[token]
    return conf




