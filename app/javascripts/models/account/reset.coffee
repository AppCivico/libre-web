# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class ResetModel extends ModelBase

  # default endpoints
  url: "/login/forgot_password/reset/:token"

  # model attributes
  defaults:
    token: null
    new_password: null

  # event bind
  events:
    'change:token': 'onChangeToken'


  # on change user id
  onChangeToken: (model, token) ->
    @url = "#{@urlRoot}/login/forgot_password/reset/#{token}"


  # validate attributes
  validate: (p, settings) ->
    @errors = {form_error: {}}

    # card name validation (required; min: 6)
    unless p.token?
      @setError 'token', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


  resetPassword: (params = null) ->
    @set params if params?
    @save()
