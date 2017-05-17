"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class PlanModel extends ModelBase
  url: "/donor/:user_id/plan"

  # default attributes
  defaults:
    user_id: 0
    amount: 2000

  # constructor
  initialize: ->
    # set url when user_id is changed
    @on 'change:user_id', (model, user_id) =>
      @url = "#{@urlRoot}/donor/#{user_id}/plan"

    # clean amount when amount changes
    @on 'change:amount', (model, amount) =>
      amount = amount.replace(',', '').replace('.', '')
      @set 'amount', amount



