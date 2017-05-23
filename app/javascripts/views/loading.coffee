"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class LoadingView extends ViewBase
  el: '#loading'

  # show user menu
  hide: ->
    @$el.addClass 'hide'

  # show user menu
  show: ->
    @$el.removeClass 'hide'
    @$el.addClass 'fade-in'
