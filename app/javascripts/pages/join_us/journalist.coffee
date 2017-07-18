"use strict"

# requires
PageBase = require 'pages/base.coffee'
Masks = require 'lib/masks.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class JournalistPage extends PageBase
  el: document.body
  template: false

  # templates
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
    'type_note': '#register-type'
    'vehicle-only': '.vehicle-only'
    'jornalist-only': '.jornalist-only'

  # view events
  events:
    'ajax:error': 'renderError'
    'ajax:before': 'renderBefore'
    'ajax:success': 'renderSuccess'
    'click @ui.journalist-type': 'clickJournalistType'
    'change @ui.document-type': 'changeDocumentType'
    'change @ui.zipcode-input': 'getAddressByZipcode'


  # constructor
  initialize: ->
    masks = new Masks
    masks.register ['number', 'phone', 'zipcode']


  renderBefore: (event, xhr, settings) ->
    $input = $(event.target).find 'input#cellphone_number'
    phone = $input.val() or ''
    phone = "+55" + phone.replace /[\(\)]/g, ''
      .replace /\s+/g, ''

    # save changed
    $input.data 'value', $input.val()
    $input.val(phone)



  # getting zipcode
  getAddressByZipcode: (event) ->
    field = event.currentTarget
    postalcode = field.value || ""

    if postalcode.match(/^\d{8}$/) or postalcode.match(/^\d{5}\-\d{3}$/)
      try
        field.value = 'Carregando CEP...'

        # FIXME: export all this scope to an lib/plugin/service
        response = $.ajax url: "http://api.postmon.com.br/cep/#{postalcode}"
          .done (response) ->
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
              unless value?
                $el.removeAttribute 'readonly'
              else
                $el.setAttribute 'readonly', 'readonly'

            field.value = postalcode

          .fail (res) ->
            field.value = postalcode
            if res.status is 404
              alert 'O CEP digitado não pode ser encontardo'

      catch e
        field.value = postalcode


  clickJournalistType: (event) ->
    formFields = ['form', 'input', 'select']
    # setting vehicle flag
    if type = event.currentTarget.getAttribute 'data-register-type'
      if $(event.currentTarget).hasClass 'active'
        return

      if type is 'journalist'
        @getUI('vehicle-input').val '0' if type is 'journalist'
        @getUI('type_note').text '(sou um jornalista)'
      else if type is 'vehicle'
        @getUI('vehicle-input').val '1' if type is 'vehicle'
        @getUI('type_note').text '(represento um veículo)'

      # change button styles
      @getUI('journalist-type').each (i) ->
        if (this.getAttribute 'data-register-type') is type
          $(this).addClass 'active btn-success-bordered'
        else
          $(this).removeClass 'active btn-success-bordered'

      # toogle fields
      @getUI('jornalist-only').each (i) ->
        console.log this.tagName.toLowerCase()
        jThis = $(this)
        if (formFields.indexOf this.tagName.toLowerCase()) >= 0
          if type is 'journalist'
            jThis.removeAttr 'disabled'
          else
            jThis.attr 'disabled', 'disabled'
        else
          jThis.toggleClass 'hide'

      @getUI('vehicle-only').each (i) ->
        console.log this.tagName.toLowerCase()
        jThis = $(this)
        if (formFields.indexOf this.tagName.toLowerCase()) >= 0
          if type is 'vehicle'
            jThis.removeAttr 'disabled'
          else
            jThis.attr 'disabled', 'disabled'
        else
          jThis.toggleClass 'hide'

      @_showDocuments(type)


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

    $input = @$el.find 'input#cellphone_number'
    $input.val $input.data('value')

    @getRegion('form').$el.append @templates.message {
      type: 'success', message: 'Usuário cadastrado!'
    }

    # redirect to login page
    setTimeout ->
      document.location = '/account/login?rel=journalist-signup'
    , 1000

    false

  # error event
  renderError: (event, xhr, error) ->
    response = xhr.responseJSON || {}
    @_reset_messages()

    $input = @$el.find 'input#cellphone_number'
    $input.val $input.data('value')

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
    @$el.find('.input-message').remove()
    @$el.find('.has-error').toggleClass('has-error')


  _showDocuments: (type = 'journalist')->
    if docsDOM = @$('#js-journalist-document')

      if type is 'journalist'
        docsDOM.find('input[name=document_type]').removeAttr 'checked'
        docsDOM.find('input[value=cpf]').prop('checked', true)
        docsDOM.find('.form-group:first-child').show()
        docsDOM.find('input[name=cpf]').removeClass 'hide'
        docsDOM.find('input[name=cnpj]').addClass 'hide'

      else if type is 'vehicle'
        docsDOM.find('input[name=document_type]').removeAttr 'checked'
        docsDOM.find('input[value=cnpj]').prop('checked', true)
        docsDOM.find('.form-group:first-child').hide()
        docsDOM.find('input[name=cpf]').addClass 'hide'
        docsDOM.find('input[name=cnpj]').removeClass 'hide'

