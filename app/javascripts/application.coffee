"use strict"

# requires
Application = require 'lib/application.coffee'

# single point entry
module.exports = do ->
	jQuery ->
		Application.start()
