# requires
require "json3"
Config = require "config.coffee"
Renderer = require "lib/renderer.coffee"

###
# Libre SDK renderer class
###
class LibreSDK
  constructor: (args = {}) ->
    @name = args.n || "none"
    @version = args.v || 0


  getDOM: ->
    document


  getConfig: ->
    Config.env()


  render: ->
    renderer = new Renderer config: @getConfig()
    buttonList = @getDOM().querySelectorAll(".lbr-button") || []

    # FIXME: need to be better in fucture
    for element in buttonList
      element.innerHTML = renderer.render()


  @doneDonationSuccess: (event, data = {}) ->
    alert 'DONE DONATION SUCCESS'
    console.log event.data


  @doneDonationError: (event, data = {}) ->
    alert 'DONE DONATION ERROR'
    console.log data


class MessageDispatcher
  @resolve: (event) ->
    origin = event.origin or ''
    data = @getDataFromEvent event

    if origin.match 'midialibre.org'
      switch data.message
        when 'success'
          LibreSDK.doneDonationSuccess event, data
        when 'error'
          LibreSDK.doneDonationError event, data


  @getDataFromEvent: (event) ->
    return try
      JSON.parse event.data
    catch
      {}

###
# Single point entry
###
try
  sdk = new LibreSDK n:"libre-sdk", v:"1.0"
  sdk.render()

  window.addEventListener "message", (event) ->
    MessageDispatcher.resolve event
  , false

catch e
  new Error "Libre SDK Exception: #{e.message}"

