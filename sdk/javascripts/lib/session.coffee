# requires
Guid = require "lib/data/guid.coffee"
Utils = require "lib/utils.coffee"

###
# Session class
# This class handle the user session data
# author: dvinciguerra
###
module.exports = class Session

  constructor: ->
    @setDefaultAttributes()

  # load current user session
  @load: ->
    session = new Session()
    data = JSON.parse(session.getAdapter().getItem(session.getSessionKey()))

    if !Utils.isEmpty(data)
      session.setAttributes(data)
      session.id = if Utils.has(data, "id") then data.id else session.id

    session

  setDefaultAttributes: ->
    @_attributes =
      "api_key": null
      "roles": []
      "user_id": 0
      "timestamp": new Date().getTime()


  getAdapter: ->
    @_adapter = @_adapter || localStorage
    @_adapter


  getSessionKey: ->
    @_sessionKey = @_sessionKey || "libre-session"
    @_sessionKey


  getId: ->
    @_id = @_id || Guid.generate()
    @_id

  getAttr: (key = null) ->
    @_attributes[key] || null


  setAttr: (key = null, value = null, options = {}) ->
    @_attributes[key] = value if key?


  getAttributes: (options = {}) ->
    @_attributes || {}


  setAttributes: (value = null, options = {}) ->
    @_attributes = value if !Utils.isNull(value)

  isAuth: (session = null) ->
    session = session || this
    return if (session.getAttr 'api_key')? then true else false

  # get params from storage
  getItem: (key = null) ->
    data = JSON.parse(@getAdapter().getItem @getSessionKey())
    @setAttributes(data)
    if key? then @getAttr(key) else null

  # set params and persist to storage
  setItem: (key = null, value = null, duration = null) ->
    data = JSON.parse(@getAdapter().getItem @getSessionKey())
    @setAttributes(data)

    if key? and typeof key is  "string"
      @_attributes[key] = value

    else if key? and  typeof key is "object"
      @setAttributes(key)

    @save()

  # persist data attributes to storage
  save: (data = {}) ->
    attr = @getAttributes()
    attr.id = @getId()
    @getAdapter().setItem(@getSessionKey(), JSON.stringify(attr))

  # clear current session
  clear: ->
    @getAdapter().setItem(
      @getSessionKey(), JSON.stringify(@setDefaultAttributes())
    )

