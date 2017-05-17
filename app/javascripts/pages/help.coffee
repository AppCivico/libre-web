"use strict"

# requires
PageBase = require 'pages/base.coffee'

###
#  Page class
#  @author dvinciguerra
###
module.exports = class HelpPage extends PageBase
  el: $(document.body)
  template: false

  initialize: (@options) ->
    # setting page initializations


