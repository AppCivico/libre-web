# requires
require "fetch-ie8"
Promise = require "promise-polyfill"

ViewBase = require 'lib/view.coffee'
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

  # return property by key name
  @t: (key = null) ->
    @_properties[key] or ''


###
# Support Button View Component
###
class SupportButtonView extends ViewBase

  apiAddr: "//hapilibre.eokoe.com/api"
  webAddr: "//midialibre.com.br" #||  "//devlibre.eokoe.com"

  constructor: (el) ->
    super el: el
    @getDataAttributes()

    # binding events
    @listenTo el, 'click', @supportButtonClick


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
      signinAddr += "?act=support&referer=#{encodeURIComponent params.location}"

      # open signin window
      signinWindow = @windowOpen signinAddr, '_blank'

      signinWindow.addEventListener 'beforeunload', (event) ->
        #@successButtonsStatus()
        console.log 'unload signin window'
      return false

    # journalist role is not allowed
    if @isAuth() and @isJournalist()
      Message.show(text: I18n.t 'journalistNotAllowed')
      return false

    # user support (with confirmation)
    isSupportConfirmed = Message.confirmable(text: I18n.t 'supportConfirm')
    if isSupportConfirmed
      formData = new FormData()
      formData.append(key, value) for key, value of params

      # send support data
      endpoint = "#{@apiAddr}/journalist/#{params.uid}/support"
      endpoint += "?api_key=#{params.api_key}"

      supportResource = fetch endpoint, method: 'POST', body: formData

        .then (res) =>
          return res if res.status >= 300

          console.log res.json()
          Message.show(text: I18n.t 'supportSuccess')
          @successButtonStatus()

        .then (res) =>
          if res.status >= 400 and res.status < 500
            throw new Error "Error: #{res}"
          console.log res.json()

        .catch (error) ->
          console.error "Button#supportSubmit event: #{error}"

      @postMessage firstname: 'Foo', lastname: 'Bar'


  windowOpen: (location, target = '_blank', options = null) ->
    options or= 'width=530,height=550,scrollbars=no,centerscreen=yes'
    window.open location, target, options


  # getting data from query_string
  #   - solve cross domain security issue
  getDataAttributes: ->
    url = window.location
    params = (new URLSearchParams url.search.substring(1))

    @data =
      uid: params.get "uid"
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
      uid: @data.uid
      api_key: (@session().getAttr 'api_key') or ''
      referer: @data.referer
    return params



#== Button view binding
# Add button event binding
doc = document
button = doc.querySelector '.lbr-sdk-btn-support'
thanks = doc.querySelector '.lbr-sdk-btn-thanks'

doc.addEventListener 'DOMContentLoaded', ->
  new SupportButtonView button
  #new ThanksButtonView(button)
