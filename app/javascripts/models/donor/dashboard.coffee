# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class DashboardModel extends ModelBase
  url: "/donor/:user_id/dashboard"

  # default attributes
  defaults:
    user_id: 0
    libres_donated: 0
    user_plan_amount: 0


  # events
  events:
    'change:user_id': 'onChangeUserId'


  # set url when user_id is changed
  onChangeUserId: (model, user_id) ->
    @url = "#{@urlRoot}/donor/#{user_id}/dashboard"


  # save plan using always PUT method
  fetch: ->
    $.ajax {
      url: "#{@urlRoot}/donor/#{@get 'user_id'}/dashboard"
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
