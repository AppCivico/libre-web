# requires
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


  @doneDonationSuccess: ->
    alert 'DONE DONATION SUCCESS'


  @doneDonationError: ->
    alert 'DONE DONATION ERROR'



###
# Single point entry
###
try
  sdk = new LibreSDK n:"libre-sdk", v:"1.0"
  sdk.render()

  window.addEventListener "message", (event) ->
    if event.origin.match 'midialibre.com.br'
      console.log event
  , false

catch e
  new Error "Libre SDK Exception: #{e.message}"

