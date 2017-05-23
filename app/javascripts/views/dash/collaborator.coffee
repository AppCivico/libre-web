"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class CollaoratorView extends ViewBase
  el: 'section#dash-main'

  # setting template
  template: 'templates/dash/collaborator'

