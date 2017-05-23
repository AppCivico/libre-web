"use strict"

# requires
require 'jquery-ujs'

# views/components
UserMenuView = require 'views/user_menu.coffee'

# libs
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
      console.debug "Starting '#{@options.name}' controller for #{document.location.href} page..."
    super()

  # templates
  templates: {}


  # error messages
  errorList: (token) ->
    Exception.getMessage(token)


	# load templates
  @load_template: (path) =>
    template = require "templates/#{path}"
    return template

