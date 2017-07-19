# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class extends ModelBase
  url: "/journalist/:user_id/authlink"

  # default attributes
  defaults:
    user_id: 0

  # save plan using always PUT method
  load: (params = {}) ->
    $.ajax {
      url: "#{@urlRoot}/journalist/#{params.user_id}/authlink"
      method: 'GET'
      data: params
      dataType: 'json'
    }

  @load: (params = {}) ->
    model = new this
    model.load(params)


