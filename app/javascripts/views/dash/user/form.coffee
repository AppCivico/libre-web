"use strict"

# requires
ViewBase = require 'views/base.coffee'

# views/components
LoadingView = require 'views/loading.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class UserFormView extends ViewBase
  el: "section#dash-main"

  # setting template
  template: 'templates/dash/user/form'

  # loading component
  loading: new LoadingView

  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()
