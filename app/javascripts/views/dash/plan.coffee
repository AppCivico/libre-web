"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class PlanView extends ViewBase
  el: '#dash-container'

  # setting template
  template: 'templates/dash/plan'

