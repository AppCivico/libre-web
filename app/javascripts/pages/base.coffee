"use strict"

# requires
require 'jquery-ujs'

###
#  PageBase - Simple Page Base class using Marionette.Object
#  @author dvinciguerra
###
module.exports = class PageBase extends Marionette.View
  el: document.body
  template: false

  # constructor
  constructor: (@options = {}) ->
    if @options.config? and @options.config['debug']
      console.debug "Starting '#{@options.name}' controller for #{document.location.href} page..."

    super


  # templates
  templates: {}

  # error messages
  # FIXME: change name error_list to errorList
  errorList: (token) ->
    console.warn '--- Check for new error messages.'
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      when 'missing' then "é obrigatório"
      else ""

  error_list: (token) -> @errorList(token) # alias


	# load templates
  @load_template: (path) =>
    template = require "templates/#{path}"
    return template

