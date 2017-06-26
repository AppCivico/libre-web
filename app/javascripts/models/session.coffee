# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class SessionModel extends ModelBase
  url: "/login"

  # default attributes
  defaults:
    email: null
    password: null
    token: null
    new_password: null
    type: 'signin'


  # validate attributes
  validate: (args = {}, settings = {}) ->
    @errors = {form_error: {}}

    # validates signin params
    if args.type is 'signin'
      @signinValidation args, settings

    # validates forgot password params
    if args.type is 'forgot'
      @forgotPasswordValidation args, settings

    # validates reset password params
    if args.type is 'reset'
      @resetPasswordValidation args, settings

    return @errors unless _.isEmpty(@errors.form_error)


  # model actions
  authenticate: (params = null, options = null) ->
    @set params if params
    @set 'type', 'signin'
    @save(options or null)


  forgotPassword: (params = null, options = {}) ->
    @set params if params
    @set 'type', 'forgot'
    @url = "#{@urlRoot}/login/forgot_password"
    @save(options or null)


  resetPassword: (params = null, options = {}) ->
    @set params if params
    @set 'type', 'reset'
    @url = "#{@urlRoot}/login/forgot_password/reset/#{@get('token') or ''}"
    @save(options or null)


  # validations
  signinValidation: (p = {}, settings = {}) ->
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


  forgotPasswordValidation: (p = {}, settings = {}) ->
    if p.email?
      @setError 'email', 'min_invalid' unless p.email.length > 5
      @setError 'email', 'char_invalid' unless p.email.match /.*@.*/
    else
      @setError 'email', 'required'


  resetPasswordValidation: (p = {}, settings = {}) ->
    if p.new_password? and p.new_password isnt ''
      @setError 'new_password', 'min_invalid' unless p.new_password.length > 5
    else
      @setError 'new_password', 'required'


  toJSON: (params = {}) ->
    data = {}

    if @get('type') is 'signin'
      data =
        email: @get('email') or null
        password: @get('password') or null

    if @get('type') is 'forgot'
      data =
        email: @get('email') or null

    if @get('type') is 'reset'
      data =
        token: @get('token') or null
        new_password: @get('new_password') or null

    return  data
