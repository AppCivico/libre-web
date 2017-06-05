"use strict"

# requires
Session       = require 'lib/session.coffee'

# views/components
IndexView     = require 'views/dash/index.coffee'
UserFormView  = require 'views/dash/user/form.coffee'



###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter

  # routes
  routes:
    '': 'default'
    'usuario/editar': 'userEdit'


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


  userEdit: ->
    view = new UserFormView
    view.render()


  onRoute: (route) ->
    # clear header container
    unless route is 'default'
      document.getElementById('dash-header').innerHTML = ''

