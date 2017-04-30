"use strict"

# requires
JoinUsController = require 'controllers/join_us'

###
#  Routes class
#  @author dvinciguerra
###
module.exports = class JoinUsRouter extends Marionette.AppRouter
  # default controller
  controller: new JoinUsController

  # routes
  appRoutes:
    'colaborador': 'collaborator'

  onRoute: (name, path, args) ->
    console.log "-- Client navigated to \"/#{path}\"..."

