'use strict'

###
#  QueryString class
#  @author dvinciguerra
###
module.exports = class QueryString

  @getParam: (name, url = window.location.href) ->
    name = name.replace /[\[\]]/g, "\\$&"
    regex = new RegExp "[?&]#{name}(=([^&#]*)|&|#|$)"
    results = regex.exec(url)
    return null unless results
    return '' unless results[2]
    return decodeURIComponent results[2].replace(/\+/g, " ")

