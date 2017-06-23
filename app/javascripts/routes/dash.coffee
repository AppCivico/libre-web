# requires
Session = require 'lib/session.coffee'
IndexView = require 'views/dash/index.coffee'
UserFormView = require 'views/dash/user/form.coffee'
UserPlanView = require 'views/dash/user/plan.coffee'
UserPaymentView = require 'views/dash/user/payment.coffee'


###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter

  # routes
  routes:
    '': 'default'
    'usuario/editar': 'userEdit'
    'usuario/pagamento': 'userPayment'
    'usuario/plano': 'userPlan'

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


  onRoute: (route) ->
    # clear header container
    unless route is 'default'
      document.getElementById('dash-header').innerHTML = ''


  getUserRole: ->
    current = @session.get('current') or _.first(@session.get 'roles')
    @session.set('current', current) unless @session.get('current')?
    current
