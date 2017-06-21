"use strict"

# requires
PageBase = require 'pages/base.coffee'
ButtonView = require 'views/button.coffee'
AuthModel = require 'models/auth.coffee'
SupportModel = require 'models/donor/support.coffee'

RequestError = require 'lib/exception/request.coffee'


###
#  Page class
#  @author dvinciguerra
###
module.exports = class SigninPage extends PageBase
  el: document.body
  template: false

  model: new AuthModel

  templates:
    message: require 'templates/message'
    input_message: require 'templates/input_message'

  ui:
    form: 'form#login-form'
    button: 'form#login-form input[type=submit]'

  events:
    'submit @ui.form': 'onSubmitLoginForm'


  submitButton: ->
    unless @_button?
      @_button = new ButtonView el: @getUI('button')

    return @_button


  # submit event
  onSubmitLoginForm: (event) ->
    event.preventDefault()

    # form params
    @model.set @signinParams().toJSON()

    # validations
    unless @model.isValid()
      @clearMessages()
      if @model.errors? and _.has(@model.errors, 'form_error')
        @renderInputMessages($(event.currentTarget), @model.errors.form_error)
      return false

    btn = @submitButton()
    btn.state 'loading'

    try
      @model.authenticate @model.toJSON()
        .then (response, status, xhr) =>
          @clearMessages()
          @renderMessage btn.$el.parent(), {
            type: 'success'
            title: 'Bem vindo!'
            message: 'Usuário autênticado...'
          }

          # update session
          s = @session.get()
          response.donation = s.donation || {}
          @session.set response if _.isObject response

          # its a donation process
          if @query('act') is 'support'
            support = new SupportModel
            support.processSupport @supportParams()
            return false

          # its a simple login process
          setTimeout ( -> document.location = '/app'), 250

        .fail (xhr, status) =>
          @clearMessages()
          @renderMessage btn.$el.parent(), {
            type: 'danger'
            title: 'Erro!'
            message: 'Usuário ou senha inválidos'
          }

        .always ->
          btn.state 'loaded'

    catch e
      @clearMessages()
      @renderMessage btn.$el.parent(), {
        type: 'danger'
        title: 'Ops!'
        message: 'Ocorreu um erro inesperado quando tentamos enviar suar informações ao servidor'
      }
      RequestError.throws e.message

    finally
      btn.state 'loaded'


  # render message
  renderMessage: ($root = null, stash = {}) ->
    # reset messages
    @$el.find('.message').remove()
    rendered = @templates.message(stash)
    $root.append(rendered) if $root?
    rendered


  renderInputMessages: ($root = null, stash = {}) ->
    # reset messages
    @$el.find('small.input-message').remove()
    @$el.find('.has-error').toggleClass('has-error')

    for key, value of stash
      if el = $root.find("[name=#{key}]")
        el.parent().addClass 'has-error'
          .append @templates.input_message({
            content: "#{el.attr('placeholder')} #{@errorList(value)}"
          })


  clearMessages: ->
    @$el.find('.message').remove()
    @$el.find('small.error-message').remove()
    @$el.find('.has-error').toggleClass('has-error')
    return


  signinParams: ->
    @params @getUI('form')
      .permit 'email', 'password'


  supportParams: ->
    session = @session.get()
    params = session.donation || {}
    params = _.extend params, {api_key: session.api_key}
    return params
