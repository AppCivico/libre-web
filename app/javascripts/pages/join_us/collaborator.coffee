# requires
PageBase = require 'pages/base.coffee'
SessionModel = require 'models/session.coffee'
PlanModel = require 'models/donor/plan.coffee'
PersonalModel = require 'models/donor/register.coffee'
CreditCardModel = require 'models/donor/credit_card.coffee'
Button = require 'views/button.coffee'
Masks = require 'lib/masks.coffee'

SupportModel = require 'models/donor/support.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class CollaboratorPage extends PageBase
  el: document.body
  template: false

  templates:
    message: require 'templates/message'
    input_message: require 'templates/input_message'

  models:
    auth:     new SessionModel {type: 'signin'}
    personal: new PersonalModel
    plan:     new PlanModel
    billing:  new CreditCardModel

  regions:
    personal: 'form#personal-form'
    plan:     'form#plan-form'
    billing:  'form#billing-form'

  ui:
    personal: 'form#personal-form'
    plan:     'form#plan-form'
    billing:  'form#billing-form'
    navtabs:  '.nav-tabs'
    panetabs: '.js-tabcontainer'

  events:
    # field changes
    "change @ui.personal input":  'changePersonalFields'
    "change @ui.plan input":      'changePlanFields'
    "change @ui.billing input":   'changeBillingFields'
    "keyup @ui.billing input":    'changeBillingFields'
    # form submit
    "submit @ui.personal":  'submitPersonalForm'
    "submit @ui.plan":      'submitPlanForm'
    "submit @ui.billing":   'submitBillingForm'



  # constructor
  initialize: ->
    masks = new Masks
    masks.register ['cpf', 'phone', 'number', 'month_year', 'money']

    # change brand icon when model brand is changed
    @listenTo @models.billing, 'change:card_brand', @changeBrandIcon

    # restoring session and current tab
    s = @session.get() or {}
    if (_.has s, 'register_step') and (_.contains ['personal', 'plan', 'billing'], s.register_step)
      @models.personal.set 'id', s.user_id
      @enableTab(s.register_step)
      location.hash = "##{s.register_step}-pane"

  # update personal model attributes
  showPersonalFieldsError: () ->
    console.log arguments

  # update personal model attributes
  changePersonalFields: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @models.personal.set field.id, field.value


  # update personal model attributes
  changePlanFields: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @models.plan.set 'amount', field.value


  # update personal model attributes
  changeBillingFields: (event) ->
    event.preventDefault()
    field = event.currentTarget
    @models.billing.set field.id, field.value



  # submit personal data form
  submitPersonalForm: (event) ->
    event.preventDefault()

    # create a new donor
    auth  = @models.auth
    model = @models.personal

    # on invalid event
    unless model.isValid()
      @clearMessages()
      if model.errors? and _.has(model.errors, 'form_error')
        @renderInputMessages($(event.currentTarget), model.errors.form_error)
      return false

    # submit button
    btn = new Button el: @getUI('personal').find('input[type=submit]')
    btn.state 'loading'

    # submit data
    model.create()
      # request success
      .done (response, status, xhr) =>
        model.set 'id', response.id

        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success', title: 'Obrigado!', message: 'Dados salvos!'
        }

        # make user authentication
        auth.set 'email', model.get('email')
        auth.set 'password', model.get('password')
        auth.authenticate()
          .then (response, status, xhr) =>
            # update session
            s = @session.get()
            response.donation = s.donation || {}
            @session.set response if _.isObject response

            # its a donation process
            if @query('act') is 'support'
              support = new SupportModel
              support.processSupport @supportParams(), {from: 'register'}

            @enableTab('plan')

        # authentication fail is disabled

      # request error
      .fail (xhr, message, other) =>
        @renderMessage btn.$el.parent(), {
          type: 'danger'
          title: 'Desculpe!'
          message: 'Não foi possível salvar seus dados!'
        }

        # input validation messages
        response = xhr.responseJSON or {}
        if response? and _.has(response, 'form_error')
          @renderInputMessages $(event.currentTarget), response.form_error

      # request complete
      .always ->
        btn.state 'loaded'


  # submit plan data form
  submitPlanForm: (event) ->
    event.preventDefault()

    # submit button
    btn = new Button el: @getUI('plan').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    model = @models.plan
    model.set {user_id: @models.personal.id, api_key: @session.get('api_key')}
    model.create()
      # request success
      .done (response, status, xhr) =>
        model.set 'id', response.id

        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success', title: 'Obrigado!', message: 'Dados salvos!'
        }

        # goto billing step
        @enableTab('billing')

      # request error
      .fail (xhr, message, other) =>
        @renderMessage btn.$el.parent(), {
          type: 'danger'
          title: 'Desculpe!'
          message: 'Não foi possível salvar os dados de planos!'
        }

      # request complete
      .always ->
        btn.state 'loaded'


  submitBillingForm: (event) ->
    event.preventDefault()

    model = @models.billing
    model.set {user_id: @models.personal.id, api_key: @session.get('api_key')}

    # on invalid event
    unless model.isValid()
      @clearMessages()
      if model.errors? and _.has(model.errors, 'form_error')
        @renderInputMessages($(event.currentTarget), model.errors.form_error)
      return false

    # submit button
    btn = new Button el: @getUI('billing').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    model.create()
      # request success
      .done (response, status, xhr) =>
        model.request_callback(response.href)
          .done (response, status, xhr) =>
            @clearMessages()
            @renderMessage btn.$el.parent(), {
              type: 'success'
              title: 'Obrigado!'
              message: 'Dados salvos!'
            }

            # redirect to thanks page
            @redirectTo '/faca-parte/obrigado?rel=colaborador'


          .fail (xhr, message, other) =>
            unless xhr? and _.isEmpty xhr.responseJSON
              @clearMessages()
              @renderMessage btn.$el.parent(), {
                type: 'danger'
                title: 'Erro!'
                message: '[Flotum] Erro ao cadastrar dados do cartão'
              }
              console.error xhr

            btn.state 'loaded'

      .fail (xhr, message, other) =>
        @renderMessage btn.$el.parent(), {
          type: 'danger'
          title: 'Desculpe!'
          message: 'Não foi possível salvar os dados de pagamento!'
        }

        # input validation messages
        response = xhr.responseJSON or {}
        if response? and _.has(response, 'form_error')
          @renderInputMessages($(event.currentTarget), response.form_error)

          console.log response

        btn.state 'loaded'


  enableTab: (tabname) ->
    $navTabs = @getUI('navtabs')
    $paneTabs = @getUI('panetabs')

    $navTabs.find('.js-navtab')
      .removeClass('active')

    $paneTabs.find('.js-tabpanes')
      .removeClass('active')

    switch tabname
      when 'personal'
        $navTabs.find('a[href="#personal-pane"]').parent().addClass('active')
        $paneTabs.find("#personal-pane").addClass('active')

      when 'plan'
        $navTabs.find('a[href="#plan-pane"]').parent().addClass('active')
        $paneTabs.find("#plan-pane").addClass('active')

      when 'billing'
        $navTabs.find('a[href="#billing-pane"]').parent().addClass('active')
        $paneTabs.find("#billing-pane").addClass('active')

    # save register stap status
    @session.set('register_step', tabname)


  # change brand icon
  changeBrandIcon: (model, brand) ->
    $icon = @getUI('billing').find('#card-brand-icon')
    switch brand
      when 'visa'
        $icon.attr 'title', 'Cartão Visa'
        $icon.removeClass 'fa-credit-card-alt fa-cc-visa fa-cc-mastercard'
          .addClass 'fa-cc-visa text-green'
      when 'mastercard'
        $icon.attr 'title', 'Cartão MasterCard'
        $icon.removeClass 'fa-credit-card-alt fa-cc-visa fa-cc-mastercard'
          .addClass 'fa-cc-mastercard text-green'
      else
        $icon.attr 'title', 'Cartão não identificado'
        $icon.removeClass 'fa-credit-card-alt fa-cc-visa fa-cc-mastercard text-green'
          .addClass 'fa-credit-card-alt text-muted'


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

    if els = $root.find "input,select,textarea"
      for el in els
        if stash[el.name]?
          el.focus()
          break

  clearMessages: ->
    @$el.find('.message').remove()
    @$el.find('small.error-message').remove()
    @$el.find('.has-error').toggleClass('has-error')
    return

  supportParams: ->
    session = @session.get()
    params = session.donation || {}
    params = _.extend params, {api_key: session.api_key}
    return params
