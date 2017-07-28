# requires
ViewBase = require 'views/base.coffee'
DashboardModel = require 'models/donor/dashboard.coffee'
I18n = require 'lib/i18n.coffee'
Message = require 'views/message.coffee'

module.exports = class extends ViewBase
  el: 'section#dash-header'

  template: 'templates/dash/header.eco'

  model: new DashboardModel

  # load statistics and render
  render: ->
    @model.set @headerParams()
    if @model.get('current') is 'donor'
      @model.fetch()
        .then (json) =>
          @model.set json
          ($ '.number-title > span').text json.length || 0
          super json

        .fail (res) ->
          Message.show
            content: I18n.t 'error/header_message'

    super()


  headerParams: ->
    @session.get() || {}
