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
    amount: 0

  # constructor
  initialize: ->
    @on 'change:user_id', (model, user_id) =>
      @url = "#{@urlRoot}/donor/#{user_id}/plan"



