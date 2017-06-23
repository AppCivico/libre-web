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

  id: Guid.generate()

  # session default attributes
  attributes:
    api_key: null
    roles: []
    user_id: 0

  # update attributes from store and return key value
  get: (key = null) ->
    @attributes = @adapter.get(@sessionKey) or @attributes
    return @attributes[key] if key?
    return @attributes


  # set an attribute and store
  set: (key = null, value = null, duration = null) ->
    @attributes = @adapter.get(@sessionKey) or @attributes

    if key? and _.isString key
      @attributes[key] = value
    else if key? and _.isObject key
      @attributes = key

    @save()


  # persist atributes
  save: (data) ->
    @attributes = _.extend @attributes, {id: @id}
    @adapter.set @sessionKey, @attributes


  # load current session
  @load: ->
    session = (new @)
    data = session.adapter.get session.sessionKey

    unless _.isEmpty data
      session.attributes = data
      session.id = data.id if _.has data, 'id'

    session

  # clear session keys
  clear: ->
    s = new Session
    @adapter.set @sessionKey, s.attributes

  # return storage name
  storageName: () ->
    @adapter.storage

  # is session new
  isNew: ->
    if @attributes.api_key? then true else false

