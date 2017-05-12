"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class Button extends ViewBase
  template: false

  stateName: 'none'

  # get or set label
  label: (text = null) ->
    return @$el.val text if text?
    return @$el.val() unless text?

  # disable view
  disable: (bool = true) ->
    return @$el.attr 'disabled', true if bool
    return @$el.removeAttr 'disabled' unless bool


  state: (state, options = {}) ->
    throw new Error 'Element not defined' unless @$el?

    switch state
      when 'loading'
        @setLabel(if options.label? then options.label else 'Salvando...')
        @$el.attr 'data-changed', @$el.val()
        @$el.attr 'disabled', true
        @$el.stateName = 'loading'

      when 'loaded'
        @setLabel(if options.label? then options.label else @$el.attr 'data-changed')
        @$el.removeAttr 'data-changed'
        @$el.removeAttr 'disabled'
        @$el.stateName = 'loaded'

      when 'hide'
        @$el.addClass 'hide'
        @$el.stateName = 'hide'

      when 'show'
        @$el.removeClass 'hide'
        @$el.stateName = 'show'

      else
        @$el.stateName = 'none'

