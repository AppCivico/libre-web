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
    if text? then @$el.val(text) else @$el.val()

  # disable view
  disable: (bool = true) ->
    return @$el.attr 'disabled', true if bool
    return @$el.removeAttr 'disabled' unless bool


  state: (state, options = {}) ->
    throw new Error 'Element not defined' unless @$el?

    switch state
      when 'loading'
        @$el.attr 'data-changed', @label()
        @label(if options.label? then options.label else 'Salvando...')
        @$el.attr 'disabled', true
        @$el.stateName = 'loading'

      when 'loaded'
        @label(if options.label? then options.label else @$el.attr('data-changed'))
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

