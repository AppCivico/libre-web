"use strict"

# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class AuthModel extends ModelBase
  url: "/login"

  # default attributes
  defaults:
    email: null
    password: null


  # authenticate user by email and password
  authenticate: (params = {email: null, password: null}, options = null) ->
    @set {email: params.email, password: params.password}
    @save(options or null)

