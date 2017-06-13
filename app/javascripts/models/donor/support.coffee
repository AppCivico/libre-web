'use strict'


# requires
ModelBase = require 'models/base.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class SupportModel extends ModelBase
  url: "/journalist/:journalist_id/support"

  # default attributes
  defaults:
    uid: 0


  # events
  events:
    'change:uid': 'onChangeJournalistId'


  # set url when user_id is changed
  onChangeJournalistId: (model, uid) ->
    @url = "#{@urlRoot}/journalist/#{uid}/support"


  # save plan using always PUT method
  fetch: ->
    $.ajax {
      url: "#{@urlRoot}/journalist/#{@get('uid')}/support"
      method: 'POST'
      data: @toJSON() || {}
      dataType: 'json'
    }

