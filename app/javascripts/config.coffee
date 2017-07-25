
# requires
Config = null

try
  Config = require 'config/production.coffee'
  Config.environment = 'production'
catch
  Config = require 'config/development.coffee'
  Config.environment = 'development'

###
#  Application config class
#  @author dvinciguerra
###
module.exports = Backbone.Config = Config
