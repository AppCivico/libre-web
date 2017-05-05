"use strict"

# requires
IndexView = require '../views/dash/index.coffee'
JournalistView = require '../views/dash/journalist.coffee'
CollaboratorView = require '../views/dash/collaborator.coffee'

###
#  Controller class
#  @author dvinciguerra
###
module.exports = class DashController extends Marionette.Object

  initialize: (@options = {})->


  default: ->
    view = new IndexView
    view.render()


  collaborator: ->
    view = new CollaboratorView
    view.render()


  journalist: ->
    view = new JournalistView
    view.render()


