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
    api_key: ''
    donor_id: 0

  # events
  events:
    'change:uid': 'onChangeJournalistId'


  # set url when user_id is changed
  onChangeJournalistId: (model, uid) ->
    @url = "#{@urlRoot}/journalist/#{uid}/support"


  # save support
  save: (params = {}) ->
    @set params
    @url = "#{@urlRoot}/journalist/#{@get('uid')}/support?api_key=#{@get('api_key')}"
    super()


  # specialized method to process donor support
  processSupport: (params = {}) ->
    @save params
      .done (res) ->
        alert 'Muito obrigado! Sua colaboração foi computada com sucesso.'

      .fail (res) ->
        alert "Desculpe! Ocorreu algum erro ao processar a sua colaboração."

      .always ->
        document.location = params.referer


  findSupports: (params = {}) ->
    @set params
    @url = "#{@urlRoot}/donor/#{@get('donor_id')}/support?api_key=#{@get('api_key')}"
    $.ajax {
      url: @url or ''
      method: 'GET'
      data: @toJSON()
      type: 'json'
    }
