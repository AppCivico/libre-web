"use strict"

# requires
require 'jquery-ujs'

# views/components
UserMenuView = require 'views/user_menu.coffee'

# libs
Params = require 'lib/params.coffee'
Session = require 'lib/session.coffee'
Exception = require 'lib/exception.coffee'
QueryString = require 'lib/query_string.coffee'


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
    # form string seelctor
    return if typeof form is 'string'
      Params.init document.querySelector(form)

    # for jQuery instance object
    else if form instanceof jQuery
      if form.length > 0 and form.get(0).tagName is 'FORM'
        Params.init form.get(0)
      else
        # exception
        throw new Error 'jQuery object dont returned an form element'

    # for element instance
    else if typeof form is 'object' and not form instanceof jQuery
      Params.init form

    # not allowed object
    else
      throw new Error 'Element must be a query selector, jquery or an element'


  # get query string param
  query: (name) ->
    QueryString.getParam(name)


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

