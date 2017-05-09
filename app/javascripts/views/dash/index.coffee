"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class IndexView extends ViewBase
  el: '#dash-container'

  # setting template
  template: 'templates/dash/index'

  # setting model
  stash:
    title: 'dash#index (no content)'