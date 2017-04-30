"use strict"

# requires
ModuleBase = require 'modules/base'
Router = require 'routes/join_us'

###
#  Module class
#  @author dvinciguerra
###
module.exports = class JoinUsModule extends ModuleBase

  # before:start event
  onBeforeStart: ->
    console.log "Hello, this is '#{@options.name}' module running at '#{document.location.href}'..."


  # start event
  onStart: () ->
    router = new Router {
      name: @options.name, config: @options.config
    }

    Backbone.history.start {
      root: "/faca-parte", pushState: false
    }


