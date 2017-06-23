"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class ForgotModel extends ModelBase

  # default endpoints
  url: "/login/forgot_password"

  # model attributes
  defaults:
    email: null


  # validate attributes
  validate: (p, settings) ->
    @errors = {form_error: {}}

    # card name validation (required; min: 6)
    if p.email?
      @setError 'email', 'min_invalid' unless p.email.length > 5
      @setError 'email', 'char_invalid' unless p.email.match /.*@.*/
    else
      @setError 'email', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


