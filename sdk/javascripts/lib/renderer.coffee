
JSON.Utils = class
  @serialize = (json = {}) ->
    data = []
    for key, value of json
      data.push "#{encodeURIComponent(key)}=#{encodeURIComponent(value)}"
    data.join '&'


###
# Renderer class
# author: dvinciguerra
###
module.exports = class

  constructor: (args = {}) ->
    @_config = args.config || {}


  getConfig: ->
    @_config


  render: ->
    data = @getDataAttributes()
    return """
      <iframe class="lbr-sdk-iframe-button"
        src="//midialibre.com.br/sdk/v1/button?#{JSON.Utils.serialize(data)}"
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

