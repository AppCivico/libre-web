
# requires
ViewBase = require 'views/base.coffee'
Loading = require 'views/loading.coffee'
DashboardModel = require 'models/journalist/dashboard.coffee'

module.exports = class extends ViewBase
  el: 'section#dash-main'

  template: 'templates/dash/journalist/index.eco'

  model: new DashboardModel

  initialize: ->
    @loading = new Loading
    @loading.show()


  render: ->
    @model.set @dashboardParams()
    @model.fetch()
      .done (res) =>
        @stash 'supports', res || []
        super

      .always (res) =>
        super

    @stash 'supports', []
    super


  onRender: ->
    @loading.hide()


  dashboardParams: ->
    session = @session.get()
    return {
      api_key: session.api_key
      user_id: session.user_id
    }
