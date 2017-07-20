
Config = require 'config.coffee'
Utils = require 'lib/utils.coffee'

###
# Renderer class
# author: dvinciguerra
###
module.exports = class

  #webAddr: "//midialibre.com.br"
  webAddr: '//midialibre.org'

  constructor: (args = {}) ->
    @_config = Config.all()
    @webAddr = @_config['base']


  getConfig: ->
    @_config


  render: ->
    data = @getDataAttributes()
    config = @getConfig()

    return """
      <iframe class="lbr-sdk-iframe-button"
        src="#{@webAddr}/sdk/v1/button?#{Utils.serialize data}"
        frameborder="0"
        scrolling="no"
        style="height:30px;width:140px;overflow:hidden">
      </iframe>
    """

  getDataAttributes: ->
    @data = {}
    element = document.querySelector('.lbr-button')

    for attr in element.attributes
      if attr.name? and attr.name.match /^data-/
        key = attr.name.replace /^data-/, ''
        @data[key] = attr.value

    # add some informations
    @data['api_key'] = ''

    url = document.location
    unless @data.title?
      @data.title = document.title || ""

    unless @data.referer?
      @data.referer = encodeURIComponent(url.href)

    unless @data.location?
      @data.location = encodeURIComponent(url.href)

    @data

