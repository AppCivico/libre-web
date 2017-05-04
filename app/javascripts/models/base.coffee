"use strict"

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

  # generic abstraction of ajax request
  request: (options = {}) ->
    $.ajax(options)


