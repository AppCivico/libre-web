# requires
Session = require 'lib/session.coffee'
IndexView = require 'views/dash/index.coffee'
DashboardView = require 'views/dash/header.coffee'
UserFormView = require 'views/dash/user/form.coffee'
UserPlanView = require 'views/dash/user/plan.coffee'
UserPaymentView = require 'views/dash/user/payment.coffee'
SDKButtonView = require 'views/dash/journalist/sdk_button.coffee'


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
    view = new UserFormView
    view.render()


  userPlan: ->
    current = @getUserRole()
    view = new UserPlanView
    view.render()


  userPayment: ->
    current = @getUserRole()
    view = new UserPaymentView
    view.render()

  sdkButton: ->
    current = @getUserRole()
    document.location = '/notfound' if current isnt 'journalist'

    view = new SDKButtonView
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
