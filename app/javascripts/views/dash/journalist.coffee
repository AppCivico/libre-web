"use strict"

# requires
ViewBase = require 'views/base.coffee'
LoadingView = require 'views/loading.coffee'
DashboardModel = require 'models/journalist/dashboard.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class JournalistView extends ViewBase
  el: 'section#dash-main'

  template: 'templates/dash/journalist/index.eco'

  loading: new LoadingView

  model: new DashboardModel


  render: ->
    @model.set @dashboardParams()
    @model.fetch()
      .done (res) =>
        @stash 'supports', res || []

      .fail (res) ->
        console.log res

      .always (res) =>
        super()

    @stash 'supports', []
    super()


  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()


  dashboardParams: ->
    session = @session.get()
    return {
      api_key: session.api_key
      user_id: session.user_id
    }
