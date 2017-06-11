"use strict"

# requires
Params = require 'lib/params.coffee'
Session = require 'lib/session.coffee'


###
#  View base class
#  @author dvinciguerra
###
module.exports = class ViewBase extends Marionette.View
  el: document.body
  template: false

  # session attribute
  session: Session.load()

  # templates
  templates: {}

  # stash variable
  _stash: {}

  # method to handle params
  params: (form = null) ->
    return if typeof form is 'string'
      Params.init document.querySelector(form)

    else if typeof form is 'object' and form.hasOwnProperty('context')
      Params.init form[0]

    else if typeof form is 'object' and form.tagName is 'FORM'
      Params.init form

    else
      throw new Error 'Element must be a query selector, jquery or an element'


  # set and get for stash
  stash: (key = null, value = undefined) ->
    return @_stash[key] = value if key? and value isnt undefined
    return @_stash[key] or null if key? and value is undefined
    return @_stash


  # setting default renderer customizations
  setRenderer: (template, data, view) ->
    data = _.extend data, {stash: view.stash}
    template = if _.isFunction(obj) then obj else require(obj)
    return template(data)
