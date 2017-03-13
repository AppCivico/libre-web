"""
  NAME
    URI Helper

  DESCRIPTION
    This helpers to get uri query string key/value

  SINOPSYS

     params = URI.init().query()

  AUTHOR
    Daniel Vinciguerra @dvinciguerra
"""

# URI helper
@URI =
  # class attributes
  _location: document.location.href || ""


  # class methods
  init: (location=document.location.href) ->
    @_location = location
    this


  absolute: () ->
    @_location || document.location.href


  relative: () ->
    document.location.pathname


  query: () ->
    list = window.location.search.substr(1).split('&')
    return {} if list is ""

    params = {}
    for item in list
      kv = item.split('=', 2)
      if kv.length is 1
        params[kv[0]] = ""
      else
        params[kv[0]] = decodeURIComponent(kv[1].replace(/\+/g, " "))

    params
