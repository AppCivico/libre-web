
module.exports = class
  el: '#loading'

  constructor: ->
    @$el = ($ @el)

  hide: ->
    @$el.fadeOut 2000, =>
      @$el.addClass 'hide'

  show: ->
    @$el.removeClass 'hide'
