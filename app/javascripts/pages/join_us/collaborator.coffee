"use strict"

# requires
PageBase = require 'pages/base.coffee'
PersonalModel = require 'models/register_donor'

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
    #plan: new PlanModel()
    #billing: new PlanModel()


  # events
  regions:
    personal: 'form#personal-form'
    plan:     'form#plan-form'
    billing:  'form#billing-form'


  # ui elements
  ui:
    personal: 'form#personal-form'
    plan: 'form#plan-form'
    billing: 'form#billing-form'
    navtabs: '.nav-tabs'
    panetabs: '.tab-container'

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


  submitPersonalForm: (event) ->
    event.preventDefault()

    # submit button
    # TODO: create a view component to submit form button
    $button = @getUI('personal').find('input[type=submit]')
    $button.attr('data-changed', $button.val())
    $button.val('Salvando informações...')
    $button.attr('disabled', true)

    # create a new donor
    model = @models.personal
    model.create()
      .done (res) =>
        @clearMessages()
        @renderMessage $button.parent(), {
          type: 'success', title: 'Obrigado!', message: 'Dados salvos!'
        }
        @enableTab('plan')

      .fail (xhr, message, other) =>
        @renderMessage $button.parent(), {
          type: 'danger', title: 'Desculpe!', message: 'Não foi possível salvar seus dados!'
        }

        # input validation messages
        response = xhr.responseJSON or {}
        if response? and _.has(response, 'form_error')
          @renderInputMessages($(event.currentTarget), response.form_error)

        @enableTab('plan')

      .always =>
        $button.val($button.data('changed'))
        $button.removeAttr('disabled')



  submitPlanForm: (event) ->
    console.log event


  submitBillingForm: (event) ->
    console.log event


  enableTab: (tabname) ->
    $navTabs = @getUI('navtabs')
    $paneTabs = @getUI('panetabs')

    $navTabs.find('.js-navtab').removeClass('active')

    switch tabname
      when 'personal'
        $navTabs.find('a[href="#personal-pane"]').addClass('active')
      when 'plan'
        $navTabs.find('a[href="#plan-pane"]').addClass('active')
      when 'billing'
        $navTabs.find('a[href="#billing-pane"]').addClass('active')


  renderMessage: ($root = null, stash = {}) ->
    # reset messages
    @$el.find('.message').remove()
    rendered = @templates.message(stash)
    $root.append(rendered) if $root?
    rendered



  renderInputMessages: ($root = null, stash = {}) ->
    # reset messages
    @$el.find('small.error-message').remove()
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

