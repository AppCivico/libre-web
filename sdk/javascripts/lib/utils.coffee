###
# Utils class
# This is a simple class that has some common methods
# author: @dvinciguerra
###
module.exports = class Utils

  # helpers
  @merge: (obj = null, src = null) ->
    return null unless obj? or src?

    if typeof obj is "object"
      for key in src
        obj[key] = src[key]
    obj


  @has: (obj = null, str) ->
    return false unless obj?

    if typeof obj is "object"
      return if obj.hasOwnProperty(str) then true else false

    if typeof obj is "string"
      return if obj.match(new RegExp str) then true else false

    return false


  # validations
  @isEmpty: (o = null) ->
    return true if o is null or o.length is 0
    if (typeof o is "string" and not o?) or o is "" or o.length is 0
      true
    else
      false


  @isNull: (o = null) ->
    unless o? then true else false


  @isString: (o = null) ->
    if typeof o is "string" then true else false

