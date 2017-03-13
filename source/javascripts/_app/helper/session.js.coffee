#NAME
#  Session Helper
#
#DESCRIPTION
#  This helper provide an interface that gives to dev a session manager
#  to store data
#
#SINOPSYS
#
#  # simple set
#  session().set 'user', {
#   id: 1
#   name: 'Joe Doe'
#  }
#
#  # simple get
#  session().get 'user'
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra

# session helper
try
  @session = () ->
    if typeof(store) isnt 'undefined'
      # using store.js
      return store
    else
      # simple fail and in-memory polyfill (redirect will lost values)
      console.warn 'Session storage lib is not present! Returning a simple and in-memory polyfill.'
      App._session = {}
      return {
        get: (key) ->
          App._session[key]
        set: (key, value) ->
          App._session[key] = value
      }

catch e
  console.log e.message


