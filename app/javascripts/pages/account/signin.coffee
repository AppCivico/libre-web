"use strict"

# requires
PageBase        = require 'pages/base.coffee'

# models
AuthModel      = require 'models/auth'

# views/components
Button          = require 'views/button'


###
#  Page class
#  @author dvinciguerra
###
module.exports = class SigninPage extends PageBase
  el: 'form#login-form'
  template: false

  # templates
  templates:
    message: require 'templates/message'
    input_message: require 'templates/input_message'

  # model
  model: new AuthModel

  # ui elements
  ui:
    main: 'form#login-form'

  # events
  events:
    # TODO: change usj to page and components
    'ajax:error': 'renderError'
    'ajax:success': 'renderSuccess'
    'change input, radio, checkbox': 'changeFormFields'


  # update model when input changes
  changeFormFields: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @model.set field.id, field.value


  # success ajax callback
  renderSuccess: (event, json) ->
    @_reset_messages()
    @$el.append @templates.message {type: 'success', message: 'Usuário autênticado!'}

    # setting session and redirect to dash
    @session.set json if _.isObject json
    setInterval ( -> document.location = '/app'), 250


  # error ajax callback
  renderError: (event, xhr, error) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @$el.find "[name=#{key}]"
          el.parent().addClass 'has-error'

    # form error message
    @$el.append @templates.message({type: 'danger', message: 'E-mail ou senha inválidos'})


  # clear template
  _reset_messages: () ->
    @$el.find('.message').remove()
    @$el.find('.has-error').toggleClass('has-error')

