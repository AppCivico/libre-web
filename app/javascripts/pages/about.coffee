"use strict"

BaseController = require 'pages/base.coffee'

# application single point entry
module.exports = class AboutController extends BaseController
  el: $(document.body)


  initialize: (@options) ->
    # setting page initializations


  bind: (@options) ->
    # setting page events here

