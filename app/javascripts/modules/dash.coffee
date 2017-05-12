"use strict"

# requires
ModuleBase = require 'modules/base.coffee'
Router = require 'routes/dash.coffee'

###
#  Module class
#  @author dvinciguerra
###
module.exports = class DashModule extends ModuleBase

  # before:start event
  onBeforeStart: ->
    console.log "Module '#{@options.name}' running at '#{document.location.href}'..."

    # hack to link navigation
    $(document).on "click", "a:not([data-bypass])", (event) ->
      event.preventDefault()
      Backbone.history.navigate event.currentTarget.getAttribute('href'), true

  # start event
  onStart: ->
    router = new Router()
    Backbone.history.start {root: "/app", pushState: true, hashChange: true}



