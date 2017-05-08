"use strict"

# requires
PageBase        = require 'pages/base.coffee'

# models
PlanModel       = require 'models/donor/plan'
PersonalModel   = require 'models/donor/register'
CreditCardModel = require 'models/donor/credit_card'

# views/components
Button          = require 'views/button'


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
    personal: new PersonalModel()
    plan: new PlanModel()
    billing: new CreditCardModel()


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
    # getting field changes
    "change @ui.personal input":  'changePersonalFields'
    "change @ui.plan input":      'changePlanFields'
    "change @ui.billing input":   'changeBillingFields'
    # submit forms
    "submit @ui.personal":  'submitPersonalForm'
    "submit @ui.plan":      'submitPlanForm'
    "submit @ui.billing":   'submitBillingForm'


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



  submitPersonalForm: (event) ->
    event.preventDefault()

    # submit button
    btn = new Button el: @getUI('personal').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    model = @models.personal
    model.create()
      .done (res) =>
        @models.personal.set 'id', res.id

        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success'
          title: 'Obrigado!'
          message: 'Dados salvos!'
        }

        if document.location.href.match /faca-parte\/colaborador$/
          document.location = '/faca-parte/obrigado?rel=1'
        else
          @enableTab('plan')

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

      .always =>
        btn.state 'loaded'



  submitPlanForm: (event) ->
    event.preventDefault()

    # submit button
    btn = new Button el: @getUI('plan').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    @models.plan.set {id: @models.personal.id }
    model = @models.plan
    model.create()
      .done (res) =>
        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success'
          title: 'Obrigado!'
          message: 'Dados salvos!'
        }
        @enableTab('billing')

      .fail (xhr, message, other) =>
        @renderMessage btn.$el.parent(), {
          type: 'danger'
          title: 'Desculpe!'
          message: 'Não foi possível salvar os dados de planos!'
        }

        # input validation messages
        response = xhr.responseJSON or {}
        if response? and _.has(response, 'form_error')
          @renderInputMessages $(event.currentTarget), response.form_error

        @enableTab('billing')

      .always =>
        btn.state 'loaded'



  submitBillingForm: (event) ->
    event.preventDefault()

    # submit button
    btn = new Button el: @getUI('billing').find('input[type=submit]')
    btn.state 'loading'

    # create a new donor
    @models.billing.set {id: @models.personal.id || 28 }
    model = @models.billing
    model.create()
      .done (res) =>
        @clearMessages()
        @renderMessage btn.$el.parent(), {
          type: 'success'
          title: 'Obrigado!'
          message: 'Dados salvos!'
        }
        console.log res
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

