# requires
require "fetch-ie8"
Config = require 'config.coffee'
Utils = require 'lib/utils.coffee'
ViewBase = require 'lib/view.coffee'
Promise = require "promise-polyfill"
URLSearchParams = require 'url-search-params'


###
# Message class
###
class Message
  @show: (args = {}) ->
    unless args.text?
      throw new Error "Message#show: text #{I18n.t 'errorRequired'}"
    # native message
    alert args.text

  @confirmable: (args = {}) ->
    unless args.text?
      throw new Error "Message#confirmable: text #{I18n.t 'errorRequired'}"
    # native message
    confirm args.text

###
# I18N class
###
class I18n
  # data properties
  @_properties:
    errorRequired: 'shouldn\'t be null'
    journalistNotAllowed: 'Você não pode doar logado como jornalista'
    supportSuccess: 'Muito obrigado! Sua colaboração foi computada'
    supportConfirm: 'Confirma a contribuição de 1 Libre para este conteúdo?'
    supportError: 'Não foi possível concluir sua contribuição no momento'
    supportGenericError: """
      Um erro foi encontrado no sistema e
      por isso não conseguimos concluir a contribuição
    """

  # return property by key name
  @t: (key = null) ->
    @_properties[key] or ''

###
# Resource class
###
class Resource
  @requestError: (res) ->
    return if res.status >= 400 then true else false

  @isServerError: (res) ->
    return if res.status >= 500 then true else false

  @isRequestError: (res) ->
    return if res.status >= 400 and res.status < 500 then true else false


class Support
  @apiAddr: ("#{Config.all().api}") ? "//api.midialibre.org/api"

  @alreadyDonated: (data = {}) ->
    serialized = Utils.serialize data

    endpoint = "#{@apiAddr}/donor/#{data.user_id}/support?#{serialized}"
    return fetch endpoint, method: 'GET'

###
# Support Button View Component
###
class SupportButtonView extends ViewBase

  constructor: (el) ->
    super el: el
    params = @getDataAttributes()

    # binding events
    @listenTo el, 'click', @supportButtonClick

    # is donated?
    if @isAuth() and not @isJournalist()
      articleSupported = Support.alreadyDonated @supportedParams()
      articleSupported
        .then (res) ->
          return res.json() if res.status >= 200 and res.status < 300

        .then (json) =>
          list = json ? []
          @supportedStatus if list.length > 0 then true else false

      articleSupported.catch (res) =>
        @supportedStatus false
    else
      @supportedStatus false


  supportedStatus: (isSupported = false) ->
    button = doc.querySelector '.lbr-sdk-btn-support'
    thanks = doc.querySelector '.lbr-sdk-btn-thanks'

    if isSupported
      button.style.display = 'none'
      thanks.style.display = 'block'
    else
      button.style.display = 'block'
      thanks.style.display = 'none'


  isJournalist: ->
    roles = (@session().getAttr 'roles') or []
    return if roles[0] is "journalist" then true else false

  isDonor: ->
    roles = (@session().getAttr 'roles') or []
    return if roles[0] is "donor" then true else false

  isAuth: ->
    isAuthenticated = @session().isAuth() or false
    return if isAuthenticated then true else false


  # submit donation event
  #   *See more*
  #   /t/donor/004-support.t#L21 at AppCivico/libre-api
  supportButtonClick: (event) =>
    event.preventDefault()
    params = @supportParams()

    # not authenticated
    if not @isAuth()
      @session().setItem 'donation', params

      signinAddr = "#{@webAddr}/account/external/login"
      signinAddr += "?act=support&referer=#{encodeURIComponent params.referer}"

      # open signin window
      @signinWindow = @windowOpen signinAddr, '_blank'

      @signinWindow.addEventListener 'message', (event) =>
        data = JSON.parse event.data
        @pageReload()
        @signinWindow.close()

      # reload button iframe page
      @signinWindow.addEventListener 'beforeunload', (event) =>
        window.parent.location = window.parent.location.href
        @pageReload()

    # journalist role is not allowed
    else if @isAuth() and @isJournalist()
      Message.show(text: I18n.t 'journalistNotAllowed')
      return false

    # user support (with confirmation)
    else
      if (Message.confirmable text: I18n.t 'supportConfirm')
        formData = new FormData
        formData.append(key, value) for key, value of params

        # send support data
        endpoint = "#{@apiAddr}/journalist/#{params.id}/support"
        endpoint += "?api_key=#{params.api_key}"

        supportResource = fetch endpoint, method: 'POST', body: formData

        # success
        supportResource.then (res) =>
          return res if Resource.requestError(res)

          Message.show(text: I18n.t 'supportSuccess')
          @supportedStatus true
          @postMessage action: 'support', message: 'success', data: params || {}
          return false
          #@successButtonStatus()

        # error
        supportResource.then (res) =>
          if Resource.requestError(res)
            Message.show(text: I18n.t 'supportError')
            @supportedStatus false
            @postMessage action: 'support', message: 'error', data: res

        # handle exceptions
        supportResource.catch (error) ->
          Message.show(text: I18n.t 'supportGenericError')


  windowOpen: (location, target = '_blank', options = null) ->
    options or= 'width=530,height=550,scrollbars=no,centerscreen=yes'
    window.open location, target, options


  pageReload: ->
    document.location = document.location.href


  # getting data from query_string
  #   - solve cross domain security issue
  getDataAttributes: ->
    url = window.location
    params = (new URLSearchParams url.search.substring(1))

    @data =
      id: params.get "id"
      theme: params.get "theme"
      title: params.get "title"
      api_key: params.get "api_key"
      location: decodeURIComponent params.get("location")
      referer: decodeURIComponent params.get("referer")
    return @data


  supportParams: ->
    params =
      page_title: @data.title
      page_referer: @data.referer
      id: @data.id
      api_key: (@session().getAttr 'api_key') or ''
      referer: @data.referer
    return params

  supportedParams: ->
    s = @session()
    params = @data

    return {
      user_id: s.getAttr 'user_id'
      api_key: s.getAttr 'api_key'
      page_title: params.title
      page_referer: params.referer
    }




#== Button view binding
# Add button event binding
doc = document
button = doc.querySelector '.lbr-sdk-btn-support'
thanks = doc.querySelector '.lbr-sdk-btn-thanks'

doc.addEventListener 'DOMContentLoaded', ->
  new SupportButtonView button
  #new ThanksButtonView(button)
