"use strict"

# requires
ViewBase = require 'views/base.coffee'

# views/components
LoadingView = require 'views/loading.coffee'
DashboardView = require 'views/dash/header.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class IndexView extends ViewBase
  # view regions
  regions:
    main: "section#dash-main"
    header: "section#dash-header"

  # loading component
  loading: new LoadingView

  # on render event callback
  initialize: ->
    current = @session.get 'current'

    View = switch  current
      when 'donor' then require 'views/dash/collaborator.coffee'
      when 'journalist' then  require 'views/dash/journalist.coffee'

    @showChildView 'header', (new DashboardView).render() if current is 'donor'
    @showChildView 'main', (new View).render()

