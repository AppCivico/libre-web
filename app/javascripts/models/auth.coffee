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


  # validate attributes
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # email validation (required; matchs: /\@/)
    if p.email?
      @setError 'email', 'invalid' unless p.email.match /\@/
    else
      @setError 'email', 'required'

    # password validation (required; min: 4)
    if p.password?
      @setError 'password', 'invalid' unless p.password.length >= 4
    else
      @setError 'password', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


  # authenticate user by email and password
  authenticate: (params = {email: null, password: null}, options = null) ->
    @set {email: params.email, password: params.password}
    @save(options or null)


