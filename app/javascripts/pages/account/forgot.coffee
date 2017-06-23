"use strict"

# requires
PageBase = require 'pages/base.coffee'
ForgotModel = require 'models/account/forgot.coffee'
ButtonView = require 'views/button.coffee'

I18n = require 'lib/i18n.coffee'
FormMessage = require 'lib/mixin/form_message.coffee'
InputMessages = require 'lib/mixin/input_message.coffee'



###
#  Page class
#  @author dvinciguerra
###
module.exports = class ForgotPage extends PageBase
  # adding mixins
  _.extend ForgotPage.prototype, FormMessage.prototype
  _.extend ForgotPage.prototype, InputMessages.prototype

  # model
  model: new ForgotModel

  # ui elements
  ui:
    form: 'form#forgot-form'
    button: 'form#forgot-form input[type=submit]'

  # events
  events:
    'submit @ui.form': 'onSubmitForm'


  initialize: (args...) ->
    @setFieldsByQuery()
    super args


  submitButton: ->
    unless @_button?
      @_button = new ButtonView el: @getUI('button')
    return @_button


  # submit event
  onSubmitForm: (event) ->
    event.preventDefault()

    $form = $(event.currentTarget)
    @clearInputMessages()

    # form params
    @model.set @formParams().toJSON()

    # validations
    unless @model.isValid()
      @renderInputMessages($form, @model.errors.form_error)
      return false

    btn = @submitButton()
    btn.state 'loading', label: 'Enviando...'

    try
      @model.save()
        .done (response, status, xhr) =>
          @renderFormMessage {
            type: 'success'
            title: I18n.t 'success/forgot_title'
            message: I18n.t 'success/forgot_message'
          }

        # request error
        .fail (xhr, message, other) =>
          response = xhr.responseJSON or {}

          @renderFormMessage {
            type: 'danger'
            title: I18n.t 'error/forgot_title'
            message: I18n.t 'error/forgot_message'
          }

          # input validation messages
          if response? and _.has response, 'form_error'
            @renderInputMessages $(event.currentTarget), response.form_error

        # request complete
        .always ->
          btn.state 'loaded'

    catch e
      @renderFormMessage {
        type: 'danger'
        title: I18n.t 'error/forgot_title'
        message: I18n.t 'error/forgot_message'
      }
      RequestError.throws e.message

    finally
      btn.state 'loaded' if btn.getState() is 'loading'


  # getting form params
  formParams: ->
    $form = @getUI('form')
    @params($form).permit 'email'


  setFieldsByQuery: ->
    $('input[name=email]').val @query('email') || ''



