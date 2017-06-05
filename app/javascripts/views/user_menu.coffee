"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class UserMenuView extends ViewBase
  el: 'nav#navigation'

  # ui components
  ui:
    navbar: '#navbar'
    mobile: 'button:first-child'
    login_button: 'div.login-button'
    username: 'div.login-button > strong'
    dropdown: '.dropdown'
    signout: '.js-signout_button'

  # ui triggers
  triggers:
    'click @ui.mobile': 'mobile:button'

  events:
    'click @ui.dropdown': 'onClickDropdown'
    'click @ui.signout': 'onClickSignout'


  # constructor
  initialize: ->
    session = @session.get()

    console.log session

    if _.has(session, 'api_key') and session.api_key?
      @triggerMethod 'user:signedin', session
    else
      @triggerMethod 'user:signedout'


  # on mobile menu button pressed
  onMobileButton: (event) ->
    $navbar = @getUI('navbar')

    if $navbar.hasClass 'collapse'
      $navbar.removeClass 'collapse'
        .addClass 'collapsed in'
    else
      $navbar.removeClass 'collapsed in'
        .addClass 'collapse'


  # on click dropdown button
  onClickDropdown: (event) ->
    event.preventDefault()
    if $uiEl = $(event.currentTarget)
      $uiEl.toggleClass 'open'


  # event to render menu for user signedin
  onUserSignedin: (session) ->
    $link = @getLoginButton()
    $text = @getUI('username')

    username = if session.name.length >= 40
      "#{session.name.substr(0, 40)}..."
    else
      session.name
    $text.addClass('text-green').text "Olá, #{username}"
    $link.attr 'href', '/app'
      .attr 'title', 'Painel do usuário'
    @show()


  # event to render menu for user signedout
  onUserSignedout: ->
    $link = @getLoginButton()
    $text = @getUI('username')

    $text.removeClass('text-green').text "LOGIN"
    $link.attr 'href', '/account/login'
      .attr 'title', 'Login de usuário'
    @show()


  # signout button
  onClickSignout: (event) ->
    event.preventDefault()
    @session.clear()
    document.location = '/account/login?message=signed-out'


  # get login button
  getLoginButton: ->
    @getUI('login_button').parent()


  # show user menu
  hide: ->
    @$el.find 'ul#dash-usermenu'
      .addClass 'hide'


  # show user menu
  show: ->
    @$el.find 'ul#dash-usermenu'
      .removeClass 'hide'
