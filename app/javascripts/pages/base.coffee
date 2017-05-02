"use strict"

# requires
require 'jquery-ujs'

###
#  PageBase - Simple Page Base class using Marionette.Object
#  @author dvinciguerra
###
module.exports = class PageBase extends Marionette.View

  # constructor
  constructor: (@options = {}) ->
    if @options.config? and @options.config['debug']
      console.debug "Starting '#{@options.name}' controller for #{document.location.href} page..."

    super


  # templates
  templates: {}

  # error messages
  error_list: (token) ->
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      when 'missing' then "é obrigatório"
      else ""


	# load templates
  @load_template: (path) =>
    template = require "templates/#{path}"
    return template

