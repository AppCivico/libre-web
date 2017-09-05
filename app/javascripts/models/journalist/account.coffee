# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class DashboardModel extends ModelBase
  url: "/journalist/:user_id"

  # default attributes
  defaults:
    user_id: 0
    libres_donated: 0
    user_plan_amount: 0

  fetch: ->
    $.ajax {
      url: "#{@urlRoot}/journalist/#{@get 'user_id'}"
      method: 'GET'
      data: @toJSON() || {}
      dataType: 'json'
    }


  toJSON: ->
    return {
      user_id: @get('user_id') || 0
      api_key: @get('api_key') || null
      libres_donated: @get('libres_donated') || 0
      user_plan_amount: @get('user_plan_amount') || 0
    }
