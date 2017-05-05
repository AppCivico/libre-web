"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class JournalistPage extends PageBase
  el: document.body
  template: false

  templates:
    message: require 'templates/message'
    input_message: require 'templates/input_message'


  # events
  regions:
    form:
      el: 'form#journalist-form'
      replaceElement: false

  # ui elements
  ui:
    'journalist-type': '.js-journalist-type'
    'document-type': 'input[name=document_type]'
    'vehicle-input': 'input#vehicle'
    'zipcode-input': 'input#address_zipcode'

  # view events
  events:
    'ajax:error': 'renderError'
    'ajax:success': 'renderSuccess'
    'click @ui.journalist-type': 'clickJournalistType'
    'change @ui.document-type': 'changeDocumentType'
    'keyup @ui.zipcode-input': 'getAddressByZipcode'


  getAddressByZipcode: (event) ->
    postalcode = event.currentTarget.value

    if postalcode.match(/^\d{8}$/) or postalcode.match(/^\d{5}\-\d{3}$/)
      # FIXME: export all this scope to an lib/plugin/service
      response = $.ajax {url: "http://api.postmon.com.br/cep/#{postalcode}"}
      response.done (response) ->
        data =
          address_state: response.estado_info.nome || null
          address_city: response.cidade || null
          address_street: if response.logradouro? then response.logradouro else null
          address_residence_number: null
          address_complement: null

        # populate address fields
        for name, value of data
          $el = document.getElementById(name)
          $el.value = value || ""
          unless value? then $el.removeAttribute('readonly') else $el.setAttribute('readonly', 'readonly')


  clickJournalistType: (event) ->
    # change button styles
    $list = @getUI('journalist-type')
      .toggleClass 'active btn-success-bordered'

    # setting vehicle flag
    if type = event.currentTarget.getAttribute 'data-register-type'
      @getUI('vehicle-input').val '0' if type is 'journalist'
      @getUI('vehicle-input').val '1' if type is 'vehicle'


  changeDocumentType: (event) ->
    type = event.currentTarget.value

    if type is 'cpf'
      @$('input#cpf').removeClass 'hide'
      @$('input#cnpj').addClass 'hide'

    if type is 'cnpj'
      @$('input#cpf').addClass 'hide'
      @$('input#cnpj').removeClass 'hide'


  # succee event
  renderSuccess: (event, xhr) ->
    @_reset_messages()

    @getRegion('form').$el.append @templates.message {
      type: 'success', message: 'Usuário cadastrado!'
    }

  # error event
  renderError: (event, xhr, error) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    # input validation messages
    if response? and _.has(response, 'form_error')
      for key, value of response.form_error
        if el = @getRegion('form').$el.find "[name=#{key}]"
          el.parent().addClass 'has-error'
            .append @templates.input_message {
              content: "#{el.attr('placeholder')} #{@errorList(value)}"
            }

    # form error message
    @getRegion('form').$el.append @templates.message {
      type: 'danger', message: 'Não foi possível salvar suas informações!'
    }


  # clear template
  _reset_messages: () ->
    @$el.find('.message').remove()
    @$el.find('.has-error').toggleClass('has-error')

