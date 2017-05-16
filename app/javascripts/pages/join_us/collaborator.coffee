"use strict"

# requires
PageBase        = require 'pages/base.coffee'

# models
AuthModel       = require 'models/auth.coffee'
PlanModel       = require 'models/donor/plan.coffee'
PersonalModel   = require 'models/donor/register.coffee'
CreditCardModel = require 'models/donor/credit_card.coffee'

# views/components
Button          = require 'views/button.coffee'

TextMask        = require 'vanilla-text-mask'
TextMaskAddons  = require 'text-mask-addons'

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


  # models
  models:
    auth:     new AuthModel
    personal: new PersonalModel
    plan:     new PlanModel
    billing:  new CreditCardModel


  # events
  regions:
    personal: 'form#personal-form'
    plan:     'form#plan-form'
    billing:  'form#billing-form'


  # ui elements
  ui:
    personal: 'form#personal-form'
    plan:     'form#plan-form'
    billing:  'form#billing-form'
    navtabs:  '.nav-tabs'
    panetabs: '.js-tabcontainer'


  # view events
  events:
    # field changes
    "change @ui.personal input":  'changePersonalFields'
    "change @ui.plan input":      'changePlanFields'
    "change @ui.billing input":   'changeBillingFields'
    # form submit
    "submit @ui.personal":  'submitPersonalForm'
    "submit @ui.plan":      'submitPlanForm'
    "submit @ui.billing":   'submitBillingForm'



  initialize: ->

    # phone mask
    for el in @$el.find('[data-mask="phone"]')
      TextMask.maskInput {
        inputElement: el
        guide: false
        mask: ['(', /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d?/]
      }

    # date mask
    for el in @$el.find('[data-mask="date"]')
      TextMask.maskInput {
        inputElement: el
        guide: false
        mask: [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
      }

    # date month year mask
    for el in @$el.find('[data-mask="month_year"]')
      TextMask.maskInput {
        inputElement: el
        guide: false
        mask: [/\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
      }

    # number mask
    for el in @$el.find('[data-mask="number"]')
      pattern = TextMaskAddons.createNumberMask {allowDecimal: false, decimalSymbol: '', thousandsSeparatorSymbol: '', prefix: '', suffix: ''}
      TextMask.maskInput { inputElement: el, mask: pattern }

    # money mask
    for el in @$el.find('[data-mask="money"]')
      pattern = TextMaskAddons.createNumberMask {allowDecimal: true, decimalSymbol: ',', thousandsSeparatorSymbol: '.', decimalLimit: 2, requireDecimal:true}
      TextMask.maskInput { inputElement: el, mask: pattern }


    # restoring session and current tab
    s = @session.get() or {}
    if (_.has s, 'register_step') and (_.contains ['personal', 'plan', 'billing'], s.register_step)
      @models.personal.set 'id', s.user_id
      @enableTab(s.register_step)
      location.hash = "##{s.register_step}-pane"


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

    # submit button
    btn = new Button el: @getUI('personal').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    auth  = @models.auth
    model = @models.personal
    model.create()
      # request success
      .done (response, status, xhr) =>
        model.set 'id', response.id

        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success', title: 'Obrigado!', message: 'Dados salvos!'
        }

        # make user authentication
        a = auth.authenticate {email: model.get('email'), password: model.get('password')}
        a.then (response, status, xhr) =>
          @session.set response
          @enableTab('plan')

        # authentication fail is disabled

      # request error
      .fail (xhr, message, other) =>
        @renderMessage btn.$el.parent(), {
          type: 'danger', title: 'Desculpe!', message: 'Não foi possível salvar seus dados!'
        }

        # input validation messages
        response = xhr.responseJSON or {}
        if response? and _.has(response, 'form_error')
          @renderInputMessages $(event.currentTarget), response.form_error

      # request complete
      .always =>
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
          type: 'danger', title: 'Desculpe!', message: 'Não foi possível salvar os dados de planos!'
        }

      # request complete
      .always =>
        btn.state 'loaded'


  submitBillingForm: (event) ->
    event.preventDefault()

    # submit button
    btn = new Button el: @getUI('billing').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    model = @models.billing
    model.set {user_id: @models.personal.id, api_key: @session.get('api_key')}
    model.create()
      # request success
      .done (response, status, xhr) =>

        # callback response
        console.log response

        # request callback
        model.request_callback(response.href)
          .done (response, status, xhr) =>
            console.log arguments

            @clearMessages()
            @renderMessage btn.$el.parent(), {
              type: 'success'
              title: 'Obrigado!'
              message: 'Dados salvos!'
            }

        #@redirectTo '/faca-parte/sucesso?rel=colaborador'
        #@enableTab('billing')

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

      .always =>
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


