# namespace
App.Controller ?= {}

###
  Controller Base class
###
class App.Controller.Base

  # attributes
  link_list: [
    {id: 1, link: '/app', label: 'meu painel'}
    {id: 2, link: '/app/autoavaliacao', label: 'autoavaliação', need_plan: false}
    {id: 3, link: '/app/autoavaliacao/resultado', label: 'resultado da avaliação'}
    {id: 4, link: '/app/plano-de-acao', label: 'plano de ação'}
    {id: 5, link: '/app/dados-de-consumo', label: 'dados de consumo'}
  ]


  # default constructor
  constructor: (@options = {}) ->
    # show menu if dashboard
    @_showAdminMenu(@options)

    # default dispatch
    @init(@options)
    @bind(@options)


  # check user authentication
  check_authentication: (options={}) ->
    @current_user = session().get('user') || {}

    # redirect to signin page when user is not authenticated
    unless @current_user and @current_user["id"]? and @current_user["apikey"]?
      l = URI.relative()
      redirect_to "/?error=session_timeout&location=#{l}"

    @current_user


  # return current logged in user
  current_user: (options = {}) ->
    session().get('user') || {}


  # signout user
  signout: (options = {}) ->
    session().clear()
    redirect_to options["url"] || '/'


  # qs helper
  qs: (selector = null, scope = document) ->
    scope.querySelector(selector)

  # qsa helper
  qsa: (selector = null, scope = document) ->
    scope.querySelectorAll(selector)


  # params property
  params: (selector) ->
    Params.form(selector)


  # session property
  session: (key=null, value=null) ->
    if key? and not value?
      return session().get(key)

    if key? and value?
      return session().set(key, value)

    session()

  # template loader
  template: (selector) ->
    template = document.getElementById(selector)
    return {
      _template: template

      hasTemplate: ->
        if @_template? then true else false

      render: (stash = {}, same_origin = true) ->
        rendered = $.templates(@_template).render(stash)
        @_template.insertAdjacentHTML('beforebegin', rendered) if same_origin
        rendered
    }


  # show admin menu
  _showAdminMenu: (@options)->
    # getting controller name
    ctrl = @options.controller || null
    user = @current_user()

    if $menu = document.getElementById('dashboard-menu')
      template = ''
      for l in @link_list
        if user.has_current_plan
          # home, result, plan, update data
          template += "<a href=\"#{l.link}\">#{l.label}</a>" if l.id in [1, 3, 4, 5]
        else
          # home, step
          template += "<a href=\"#{l.link}\">#{l.label}</a>" if l.id in [1, 2]

      $menu.innerHTML = template

