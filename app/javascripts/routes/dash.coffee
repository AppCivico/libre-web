# requires
Session = require 'lib/session.coffee'
IndexView = require 'views/dash/index.coffee'
DashboardView = require 'views/dash/header.coffee'


###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter

  qs: (selector, el = document) ->
    el.querySelector selector


  # routes
  routes:
    '': 'default'
    'usuario/editar': 'userEdit'
    'usuario/pagamento': 'userPayment'
    'usuario/plano': 'userPlan'
    'sdk/gerar-botao': 'sdkButton'

  session: new Session


  # actions
  default: ->
    current = @getUserRole()
    view = new IndexView


  userEdit: ->
    View = null
    current = @getUserRole()

    if current is 'donor'
      View = require 'views/dash/collaborator/form.coffee'
    else if current is 'journalist'
      View = require 'views/dash/journalist/form.coffee'

    if View?
      view = new View
      view.render()
    else
      document.location = '/not-found?ref=user-form'


  # route /usuario/plano
  userPlan: ->
    View = null
    current = @getUserRole()

    if current is 'donor'
      View = require 'views/dash/collaborator/plan.coffee'

    if View?
      view = new View
      view.render()
    else
      document.location = '/not-found?ref=user-plan'


  # route /usuario/pagamento
  userPayment: ->
    View = null
    current = @getUserRole()

    if current is 'donor'
      View = require 'views/dash/collaborator/payment.coffee'
    else if current is 'journalist'
      View = require 'views/dash/journalist/payment.coffee'

    if View?
      view = new View
      view.render()
    else
      document.location = '/not-found?ref=user-payment'

  sdkButton: ->
    current = @getUserRole()
    document.location = '/not-found' if current isnt 'journalist'

    View = require 'views/dash/journalist/sdk_button.coffee'
    view = new View
    view.render()


  onRoute: (route) ->
    current = @getUserRole()
    $container =  @qs 'section#dash-header'

    header = new DashboardView
    header.stash 'dashboard', current
    header.render()


  getUserRole: ->
    current = @session.get('current') or _.first(@session.get 'roles')
    @session.set('current', current) unless @session.get('current')?
    current
