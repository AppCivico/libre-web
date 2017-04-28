"use strict"

require 'jquery-ujs'

module.exports = class BaseController

  @start: (options) ->
    if options.config? and options.config['debug']
      console.debug "Starting '#{options.name}' controller for #{document.location.href} page..."

    new this(options)


  # constructor
  constructor: (@options) ->
    try
      @initialize(@options)
      @bind(@options)
    catch e
      throw e

  # templates
  templates: []

  # error messages
  error_list: (token) ->
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      else ""

  # base initialize method
  initialize: (@options = {}) ->
    if options.config? and options.config['debug']
      console.debug "Calling initialize method from base class"


  # base bind method
  bind: (@options = {}) ->
    if options.config? and options.config['debug']
      console.log "Calling bind method from base class"

  # render templates
  render: (template, data, options) ->
    @templates[template](data) if @templates[template]?


	# load templates
  @load_template: (path) =>
    template = require "templates/#{path}"
    return template

