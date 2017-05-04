"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class LoginController extends PageBase
  el: 'form#login-form'
  template: false


  templates:
    message: require 'templates/message'
    input_message: require 'templates/input_message'


  events:
    'ajax:error': 'renderError'
    'ajax:success': 'renderSuccess'


  ## Events
  renderSuccess: (event, xhr) ->
    @_reset_messages()
    @$el.append @templates.message {
      type: 'success', message: 'Usuário autênticado!'
    }

  renderError: (event, xhr, error) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @$el.find "[name=#{key}]"
          el.parent().addClass 'has-error'

    # form error message
    @$el.append @templates.message {
      type: 'danger', message: 'E-mail ou senha inválidos'
    }


  # clear template
  _reset_messages: () ->
    @$el.find('.message').remove()
    @$el.find('.has-error').toggleClass('has-error')

