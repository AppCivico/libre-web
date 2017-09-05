# requires
ViewBase = require 'views/base.coffee'
ButtonView = require 'views/button.coffee'
LoadingView = require 'views/loading.coffee'
PaymentModel = require 'models/journalist/payment.coffee'
AccountModel = require 'models/journalist/account.coffee'

I18n = require 'lib/i18n.coffee'
Message = require 'lib/message.coffee'
RequestError = require 'lib/exception/request.coffee'


module.exports = class extends ViewBase
  # adding mixins
  #_.extend @prototype, FormMessage.prototype

  el: 'section#dash-main'

  # setting template
  template: 'templates/dash/journalist/payment.eco'

  # loading
  loading: new LoadingView

  model: new Backbone.Model()

  account: new AccountModel

  # ui elements
  ui:
    buttonPicPay: '#js-btn-picpay'

  # events
  events:
    'click @ui.buttonPicPay': 'integratePicPay'


  submitButton: (stateName = null) ->
    unless @_button?
      @_button = new ButtonView el: @getUI('buttonPicPay')

    if stateName?
      @_button.state stateName

    return @_button


  # generate code event
  integratePicPay: (event) ->
    event.preventDefault()

    #@clearMessages()
    btn = @submitButton 'loading'

    try
      PaymentModel.load @picpayParams()
        .done (res) =>
          if (res.picpayconnect.authurl)?
            Message.show
              type: 'success'
              title: I18n.t 'success/picpay_title'
              message: I18n.t 'success/picpay_message'
            window.open res.picpayconnect.authurl, '_blank', ''
            btn.el.textContent = 'Aguardando autorização'
            btn.el.className = btn.el.className.replace 'btn-success', 'btn-warning'
            btn.el.setAttribute 'aria-busy', 'true'
            checkAuth = setInterval( (
              ()=>
                @account.fetch()
                  .done (res) ->
                    if res.is_authlinked? and res.is_authlinked > 0
                      window.location.reload(false)
            ), 30000)

          false

        .fail (res) ->
          Message.show
            type: 'danger'
            title: I18n.t 'error/picpay_title'
            message: I18n.t 'error/picpay_message'
          false

        # request complete
        .always ->
          btn.state 'loaded'
          false

    catch e
      Message.show
        type: 'danger'
        title: I18n.t 'error/picpay_title'
        message: I18n.t 'error/picpay_message'

      RequestError.throws e.message
      btn.state 'loaded'


    return false

  render: ->
    @account.set @accountParams()
    @account.fetch()
      .done (res) =>
        @stash 'account', res || []
        super

      .always (res) =>
        super

    @stash 'account', []
    super


  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()


  picpayParams: ->
    data =
      user_id: @session.get 'user_id'
      api_key: @session.get 'api_key'
    return data


  clearMessages: ->
    @$el.find('.message').remove()
    false


  accountParams: ->
    session = @session.get()
    return {
      api_key: session.api_key
      user_id: session.user_id
    }

