"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class HeaderView extends ViewBase
  el: 'section#dash-header'

  # setting template
  template: 'templates/dash/header'

