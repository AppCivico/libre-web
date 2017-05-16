"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class SigninModel extends ModelBase

  # default endpoints
  url: "/login"

  # model attributes
  defaults:
    email: null
    password: null
    keep: false


  # attribute validation
  validate: (attrs, options) ->
    errors = {}
    console.log arguments
    return errors


  find: (options = {}) ->
    @request(options)

