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

  getLabel: () ->
    @$el.val()
    this


  setLabel: (text) ->
    @$el.val(text)
    this


  disable: (bool) ->
    if bool
      @$el.attr 'disabled', true
    else
      @$el.removeAttr 'disabled'
    this


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

    this
