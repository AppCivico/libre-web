# requires
PageBase = require 'pages/base.coffee'
SessionModel = require 'models/session.coffee'
ButtonView = require 'views/button.coffee'

I18n = require 'lib/i18n.coffee'
FormMessage = require 'lib/mixin/form_message.coffee'
InputMessages = require 'lib/mixin/input_message.coffee'

RequestError = require 'lib/exception/request.coffee'


###
#  Page class
#  @author dvinciguerra
###
module.exports = class ResetPage extends PageBase
  # adding mixins
  _.extend ResetPage.prototype, FormMessage.prototype
  _.extend ResetPage.prototype, InputMessages.prototype

  # model
  model: new SessionModel {type: 'reset'}

  # ui elements
  ui:
    form: 'form#reset-form'
    button: 'form#reset-form input[type=submit]'

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
      console.log @model
      @renderInputMessages($form, @model.errors.form_error)
      return false

    btn = @submitButton()
    btn.state 'loading', label: 'Enviando...'

    try
      @model.resetPassword()
        .done (response, status, xhr) =>
          @renderFormMessage {
            type: 'success'
            title: I18n.t 'success/reset_title'
            message: I18n.t 'success/reset_message'
          }

        # request error
        .fail (xhr, message, other) =>
          response = xhr.responseJSON or {}

          @renderFormMessage {
            type: 'danger'
            title: I18n.t 'error/reset_title'
            message: I18n.t 'error/reset_message'
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
        title: I18n.t 'error/reset_title'
        message: I18n.t 'error/reset_message'
      }
      RequestError.throws e.message

    finally
      btn.state 'loaded' if btn.getState() is 'loading'


  # getting form params
  formParams: ->
    $form = @getUI('form')
    @params($form).permit 'token', 'new_password'


  setFieldsByQuery: ->
    $('input[name=token]').val @query('token') || ''



