"use strict"

# requires
Store = require 'store'
Guid = require 'lib/data/guid.coffee'


###
#  Session class
#  @author dvinciguerra
###
module.exports = class Session
  # session key
  sessionKey: 'libre-session'

  # setting adapter
  adapter: Store

  # session default attributes
  attributes:
    id: Guid.generate()
    api_key: null
    roles: []
    user_id: 0


  constructor: ->
    @save() # session creation on class instance


  # update attributes from store and return key value
  get: (key = null) ->
    @attributes = @adapter.get(@sessionKey)
    return @attributes[key] if key?
    return @attributes


  # set an attribute and store
  set: (key = null, value = null, duration = null) ->
    @attributes = @adapter.get(@sessionKey) or @attributes
    @attributes[key] = value if key?
    @adapter.set @sessionKey, @attributes


  # force persist atributes
  save: ->
    @adapter.set(@sessionKey, @attributes)


  # return storage name
  storageName: () ->
    @adapter.storage

