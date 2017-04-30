"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class ContactController extends PageBase
  el: $('form#contact-form')


  ## Attributes
  templates:
    message: @load_template('contato/message')
    input_error: @load_template('contato/input_message')


  error_list: (token) ->
    switch token
      when 'invalid' then "é inválido!"
      when 'required' then "é obrigatório!"
      when 'empty_is_invalid' then "é obrigatório!"
      else ""

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
    @el.append @render('message', {
        type: 'success', message: 'Sua mensagem foi enviada!'
      })

  renderError: (event, response) ->
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @el.find "[name=#{key}]"
          el.parent()
            .addClass 'has-error'
            .append @render('input_error', {content: "#{el.attr('placeholder')} #{@error_list(value)}"})

    # form error message
    @el.append @render('message', {
      type: 'danger', message: 'Não foi possível enviar sua mensagem!'
    })



  # clear template
  _reset_messages: () ->
    @el.find('.message').remove()
    @el.find('small.error-message').remove()
    @el.find('.has-error').toggleClass('has-error')

