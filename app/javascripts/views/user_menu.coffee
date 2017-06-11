"use strict"

# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class UserMenuView extends ViewBase
  el: 'nav#navigation'

  state: 'signedout'

  # ui components
  ui:
    navbar: '#navbar'
    mobile: 'button:first-child'
    login_button: 'div.login-button'
    username: 'div.login-button > strong'
    dropdown: '.js-username_button'
    signout: '.js-signout_button'
    menu: '.dropdown-menu'

  # ui triggers
  triggers:
    'click @ui.mobile': 'mobile:button'

  events:
    'click @ui.dropdown': 'onClickDropdown'
    'click @ui.signout': 'onClickSignout'
    'click @ui.menu': 'onClickMenuLink'


  # constructor
  initialize: ->
    session = @session.get()

    if _.has(session, 'api_key') and session.api_key?
      @triggerMethod 'user:signedin', session
      @state = 'signedin'
    else
      @triggerMethod 'user:signedout'
      @state = 'signedout'


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
    if @state is 'signedin'
      event.preventDefault()
      if $uiEl = $(event.currentTarget).parent()
        $uiEl.toggleClass 'open'


  # on click dropdown menu item button
  onClickMenuLink: (event) ->
    if $uiEl = $(event.currentTarget).parent()
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
    document.location = '/'


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
