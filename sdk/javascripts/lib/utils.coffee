###
# Utils class
# author: @dvinciguerra
###
module.exports = class

  # helpers
  @encode: (data) ->
    encodeURIComponent data


  @decode: (data) ->
    decodeURIComponent data


  @serialize: (json = {}) ->
    data = []
    data.push "#{@encode key}=#{@encode value}" for key, value of json
    return data.join '&'


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

