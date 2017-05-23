"use strict"

# requires
Session           = require 'lib/session.coffee'

# views/components
IndexView  = require 'views/dash/index.coffee'



###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter

  # routes
  routes:
    '': 'default'


  # session attribute
  session: new Session

  # actions
  default: ->
    # getting current role and update
    current = @session.get('current') or _.first(@session.get 'roles')
    @session.set('current', current) unless @session.get('current')?

    # render default layout
    view = new IndexView
    #view.render()

