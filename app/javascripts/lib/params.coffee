###
#  Params class
#  @author dvinciguerra
###
module.exports = class Params

  # attributes
  data: {}

  constructor: (@element = null) ->

  # return an instance of class
  @init: (element) ->
    new Params(element)

  # fields to return value
  permit: (fields...) ->
    @data = {}
    for f in fields
      @data[f] = @element[f].value
    return @

  # return as json
  toJSON: ->
    return @data

  # return as string
  toString: ->
    return JSON.stringify @data

  # return as form data
  toFormData: ->
    return @data
