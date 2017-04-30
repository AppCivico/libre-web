"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class LoginController extends PageBase
  el: $('form#login-form')


  ## Attributes
  templates:
    message: @load_template('signin/message')
    input_error: @load_template('signin/input_message')


  # constructor
  initialize: (@options) ->


  ## Bindings
  bind: (@options) ->
    @el.on 'ajax:error', @renderError(event, xhr, settings, error)
    @el.on 'ajax:success', @renderSuccess(event, xhr, settings)


  ## Events
  renderSuccess: (event, xhr) ->
    @_reset_messages()
    @el.append @render(
      'message', {type: 'success', message: 'Usuário autênticado!'}
    )

  renderError: (event, response) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @el.find "[name=#{key}]"
          el.parent().addClass 'has-error'

    # form error message
    @el.append @render('message', {
      type: 'danger', message: 'E-mail ou senha inválidos'
    })



  # clear template
  _reset_messages: () ->
    @el.find('.message').remove()
    @el.find('.has-error').toggleClass('has-error')

