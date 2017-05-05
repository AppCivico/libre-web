"use strict"

# requires
DashController = require 'controllers/dash.coffee'

###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter
  # default controller
  # FIXME: add attributes on construct
  controller: new DashController {name: @module, config: @config}


  # routes
  appRoutes:
    '':              'default'
    'colaborador':   'collaborator'
    'jornalista':    'journalist'

