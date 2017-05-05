"use strict"

# requires
ViewBase = require '../base'

###
#  View class
#  @author dvinciguerra
###
module.exports = class CollaoratorView extends ViewBase
  el: '#app-container'

  # setting template
  template: '../../templates/dash/collaborator'

