"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class JournalistView extends ViewBase
  el: '#dash-container'

  # setting template
  template: 'templates/dash/journalist'

