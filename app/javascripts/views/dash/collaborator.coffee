"use strict"

# requires
ViewBase = require 'views/base.coffee'
LoadingView = require 'views/loading.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class CollaoratorView extends ViewBase
  el: 'section#dash-main'

  # setting template
  template: 'templates/dash/collaborator'

  # loading component
  loading: new LoadingView


  # event on render
  onRender: ->
    # FIXME: fadein()
    @loading.hide()
