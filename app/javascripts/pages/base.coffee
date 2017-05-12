"use strict"

# requires
require 'jquery-ujs'

Session = require 'lib/session.coffee'


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
  constructor: (@options = {}) ->
    if @options.config? and @options.config['debug']
      console.debug "Starting '#{@options.name}' controller for #{document.location.href} page..."

    super

  # templates
  templates: {}

  # error messages
  errorList: (token) ->
    # TODO: Always check for new error messages on https://github.com/eokoe/libre-api
    # TODO: Remove messages to other class
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      when 'missing' then "é obrigatório"
      when 'alredy exists' then "já está cadastrado"
      else ""

	# load templates
  @load_template: (path) =>
    template = require "templates/#{path}"
    return template

