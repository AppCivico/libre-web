# configuration
config = require('config.coffee').env()

###
#  ModelBase - Model base class on top of Backbone.Model
#  @author dvinciguerra
###
module.exports = class ModelBase extends Backbone.Model

  # url root
  urlRoot: "#{config.api_base}"

  # configurations
  config: -> config

  # validation errors
  errors: {}

  # constructor
  initialize: ->
    @url = "#{@urlRoot}#{@url}" unless @url is "#{@urlRoot}#{@url}"

    # binding events
    @on(key, this[value], this) for key, value of @events

    super arguments


  # generic abstraction of ajax request
  request: (opts = {}) ->
    opts.url ?= @url
    opts.dataType ?= opts.dataType
    return $.ajax opts


  # save model method
  save: (args...) ->
    super args


  # create model
  create: (args...) ->
    @save(args)


  # setting form errors
  setError: (field, message) ->
    @errors.form_error = {} unless @errors.form_error?
    @errors.form_error[field] = message if field? and message?

