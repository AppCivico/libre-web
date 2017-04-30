"use strict"

# requires
Application = require 'lib/application.coffee'

# single point entry
module.exports = do ->
  document.addEventListener 'DOMContentLoaded', ->
    Application.start()
  , false

