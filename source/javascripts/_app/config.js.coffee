# namespace
@App = @App || {}

#############################
# Configs
#############################
# pre configurations
host = document.location.href || ""
define_api = (host) ->
  if host.match /saveh.com.br/
    return '//webapi.saveh.com.br/api'
  else
    return '//dapisaveh.eokoe.com/api'

@App.config =
  DEBUG: false #true
  API_BASE: define_api(host)
  CORS: true

