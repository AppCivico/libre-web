"use strict"

# requires
ViewBase = require 'views/base.coffee'

# models
DashboardModel = require 'models/donor/dashboard.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class HeaderView extends ViewBase
  el: 'section#dash-header'

  # setting template
  template: 'templates/dash/header'

  # model
  model: new DashboardModel

  render: ->
    data = {}
    @model.set @session.get() || {}
    @model.fetch()
      .then (json) =>
        @model.set json
        super()
      .fail (res) ->
        alert 'Não foi possível carregar os dados do plano atual.'

    super()
