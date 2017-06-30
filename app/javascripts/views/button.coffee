"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class Button extends ViewBase
  template: false

  # default button type
  buttonType: 'input'

  # default state
  stateName: 'none'


  # constructor
  initialize: () ->
    @buttonType = @$el[0].tagName.toLowerCase() if @$el[0]?


  # get or set label
  label: (text) ->
    if @buttonType is 'input'
      return @$el.val(text) if arguments.length > 0
      return @$el.val()
    else
      return @$el.text(text) if arguments.length > 0
      return @$el.text()



  # disable view
  disable: (bool = true) ->
    return @$el.attr('disabled', true) if bool
    return @$el.removeAttr('disabled') unless bool


  getState: ->
    @stateName


  # change status method
  state: (state, options = {}) ->
    throw new Error 'Element not defined' unless @$el?

    switch state
      when 'loading'
        @$el.attr 'data-changed', @label()
        @label options.label || @label()# if options? and options.label?
        @$el.attr 'disabled', true
        @$el.stateName = 'loading'

      when 'loaded'
        @label options.label || @$el.attr('data-changed')
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

