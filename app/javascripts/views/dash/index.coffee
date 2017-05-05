"use strict"

# requires
ViewBase = require '../base'

###
#  View class
#  @author dvinciguerra
###
module.exports = class IndexView extends ViewBase
  el: '#app-container'

  # setting template
  template: '../../templates/dash/index'

  # setting model
  stash:
    title: 'dash#index (no content)'
