"use strict"

# requires
ModuleBase = require 'modules/base'
Router = require 'routes/dash'

###
#  Module class
#  @author dvinciguerra
###
module.exports = class DashModule extends ModuleBase

  # before:start event
  onBeforeStart: ->
    console.log "Module '#{@options.name}' running at '#{document.location.href}'..."


  # start event
  onStart: () ->
    router = new Router {
      module: @options.name, config: @options.config
    }

    Backbone.history.start {
      root: "/faca-parte", pushState: true
    }


