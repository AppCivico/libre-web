"use strict"

# requires
ViewBase = require '../base'

###
#  View class
#  @author dvinciguerra
###
module.exports = class JournalistView extends ViewBase
  el: '#app-container'

  # setting template
  template: '../../templates/dash/journalist'

