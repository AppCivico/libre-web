# requires
ModelBase = require 'models/base.coffee'
PostMessage = require 'lib/mixin/post_message.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class extends ModelBase
  # adding mixins
  _.extend this.prototype, PostMessage.prototype

  idAttribute: "_id"

  url: "/journalist/:journalist_id/support"

  # default attributes
  defaults:
    id: 0
    api_key: ''
    donor_id: 0

  # events
  events:
    'change:id': 'onChangeJournalistId'


  # set url when user_id is changed
  onChangeJournalistid: (model, id) ->
    @url = "#{@urlRoot}/journalist/#{id}/support"


  # save support
  save: (params = {}) ->
    @set params
    @url = "#{@urlRoot}/journalist/#{@get 'id'}/support?api_key=#{@get('api_key')}"
    console.log "#{@urlRoot}/journalist/#{@get 'id'}/support?api_key=#{@get 'api_key'}"
    super()


  # specialized method to process donor support
  processSupport: (params = {}, options = {}) ->
    console.log params
    @save params
      .done (res) =>
        # only for popup signin
        unless document.location.href.match /faca-parte\/colaborador/
          alert 'Obrigado por colaborar com o jornalismo livre.'
          @postMessage action: 'support', message: 'success', data: {}

      .fail (res) =>
        alert "Desculpe! Ocorreu algum erro ao processar a sua colaboração."
        @postMessage action: 'support', message: 'error', data: res

      .always ->
        if document.location.href.match /faca-parte\/colaborador/
          return false

        if document.location.href.match /external\/login/
          window.close()
          return false

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


  postMessage: (data = {}, origin = "*") ->
    json = JSON.stringify data
    (window.parent || window).postMessage json, origin

