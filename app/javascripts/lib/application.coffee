"use strict"

# configuration
Config = require 'config.coffee'
window.Cofig = Config or {}


# application single point entry
module.exports = class Application
	@start: ->

		# getting config
		config = Config.env('development')

		# getting page info
		body = document.body
		controller = body.getAttribute('data-controller') ? null

		# getting an instance of controller
		if controller? and controller isnt 'App'
			Controller = require "pages/#{controller.toLowerCase()}"
			return Controller.start {name: controller, config: config}
		else
			console.warn "Page '#{document.location.href}' dont have any controller defined"


