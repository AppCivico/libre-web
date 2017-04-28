"use strict"

# requires
BaseController = require 'pages/base.coffee'

# application single point entry
module.exports = class LoginController extends BaseController
  el: $('form#login-form')


  ## Attributes
  templates:
    message: @load_template('signin/message')
    input_error: @load_template('signin/input_message')


  # constructor
  initialize: (@options) ->


  ## Bindings
  bind: (@options) ->
    @el.on 'ajax:error', (event, xhr, status, error) =>
      @ajax_error(event, xhr, status, error)

    @el.on 'ajax:success', (event, xhr, settings) =>
      @ajax_success(event, xhr, settings)


  ## Events
  ajax_success: (event, xhr, settings) ->
    @renderSuccess event, xhr

  ajax_error: (event, xhr, status, error) ->
    @renderError event, xhr.responseJSON || {}


  ## Renderers
  renderSuccess: (event, xhr) ->
    @_reset_messages()
    @el.append @render(
      'message', {type: 'success', message: 'Usuário autênticado!'}
    )

  renderError: (event, response) ->
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @el.find "[name=#{key}]"
          el.parent().addClass 'has-error'

    # form error message
    #if response? and response.error? and response.error is 'Bad email or password'
    @el.append @render('message', {
      type: 'danger', message: 'E-mail ou senha inválidos'
    })



  # clear template
  _reset_messages: () ->
    @el.find('.message').remove()
    @el.find('.has-error').toggleClass('has-error')

