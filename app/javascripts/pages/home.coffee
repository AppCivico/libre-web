"use strict"

BaseController = require 'pages/base.coffee'

# application single point entry
module.exports = class HomeController extends BaseController
  el: $(document.body)


  initialize: (@options) ->
    console.log "AQUI"


  bind: (@options) ->
    # before send ajax event
    @el.on 'ajax:beforeSend', (event, xhr, settings) =>
      @before_send(event, xhr, settings)

    # ajax error event
    @el.on 'ajax:error', (event, xhr, settings) =>
      @ajax_error(event, xhr, settings)

    # ajax success event
    @el.on 'ajax:success', (event, xhr, settings) =>
      @ajax_error(event, xhr, settings)

