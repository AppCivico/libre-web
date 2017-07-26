# configurations
window.Libre = window.Libre || {}

# requires
Config = null

try
  Config = require 'config/production.coffee'
  Config.environment = 'production'
catch
  Config = require 'config/development.coffee'
  Config.environment = 'development'



###
# Configuration class
###
module.exports = window.Libre = Config
