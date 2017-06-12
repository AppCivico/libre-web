"use strict"

# requires
require 'jquery-ujs'

# views/components
UserMenuView = require 'views/user_menu.coffee'

# libs
Params = require 'lib/params.coffee'
Session = require 'lib/session.coffee'
Exception = require 'lib/exception.coffee'


###
#  PageBase - Simple Page Base class using Marionette.Object
#  @author dvinciguerra
###
module.exports = class PageBase extends Marionette.View
  el: document.body
  template: false

  # session attribute
  session: Session.load()

  # constructor
  initialize: ->
    if @options.config? and @options.config['debug']
      name = @options.name || 'none'
      page = document.location.href
      console.debug "Starting '#{name}' controller for #{page} page..."

    super()

  # templates
  templates: {}

  # method to handle params
  params: (form) ->
    if typeof form is 'string'
      Params.init document.querySelector(form)

    else if typeof form is 'object' and form.hasOwnProperty 'context'
      Params.init form.context

    else if typeof form is 'object' and form.hasOwnProperty 'context'
      Params.init form

    else
      throw new Error 'Element must be a query selector, jquery or an element'


  # error messages
  errorList: (token) ->
    Exception.getMessage(token)


  # load templates
  @load_template: (path) ->
    template = require "templates/#{path}"
    return template


  # user page redirect
  redirectTo: (href = null) ->
    document.location = href if href?
    return false

