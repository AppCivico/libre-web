"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class ContactController extends PageBase
  el: 'form#contact-form'
  template: false

  ## Attributes
  templates:
    message: require '../templates/message'
    input_message: require '../templates/input_message'


  # view events
  events:
    'ajax:error': 'renderError'
    'ajax:success': 'renderSuccess'


  ## Renderers
  renderSuccess: (event, xhr) ->
    @_reset_messages()
    @$el.append @templates.message {
      type: 'success', message: 'Sua mensagem foi enviada!'
    }


  renderError: (event, xhr, error) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @$el.find "[name=#{key}]"
          el.parent()
            .addClass 'has-error'
            .append @templates.input_message {
              content: "#{el.attr('placeholder')} #{@errorList(value)}"
            }

    # form error message
    @$el.append @templates.message {
      type: 'danger', message: 'Não foi possível enviar sua mensagem!'
    }



  # clear template
  _reset_messages: () ->
    @$el.find('.message').remove()
    @$el.find('small.error-message').remove()
    @$el.find('.has-error').toggleClass('has-error')

