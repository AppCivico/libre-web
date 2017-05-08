"use strict"

# requires
IndexView = require 'views/dash/index.coffee'
PlanView = require 'views/dash/plan.coffee'
StatementView = require 'views/dash/statement.coffee'


###
#  Routes class
#  @author dvinciguerra
###
module.exports = class DashRouter extends Marionette.AppRouter

  # routes
  routes:
    '': 'default'
    'plano': 'plan'
    'extrato': 'statement'


  # actions
  default: ->
    view = new IndexView
    view.render()


  plan: ->
    view = new PlanView
    view.render()


  statement: ->
    view = new StatementView
    view.render()


