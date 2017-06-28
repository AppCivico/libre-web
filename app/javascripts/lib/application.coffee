"use strict"

# configuration
Config = require 'config.coffee'
Backbone.Config.environment = 'development' # 'production'

UserMenuView = require 'views/user_menu.coffee'



# Backbone.ajax hack for resources with our perl api
# (force data, content_type and process_data)
Backbone.rest = $.ajax
_backboneAjax = Backbone.ajax
Backbone.ajax = (options = {}) ->
  options.data = JSON.parse(options.data)
  options.contentType = 'application/x-www-form-urlencoded'
  options.processData = true
  return _backboneAjax(options)


# config renderer
# FIXME: replace this and put into view|page base classes
Marionette.Renderer.render = (obj, data = {}, view) ->
  data = _.extend(data, {stash: view._stash}) if view._stash?
  template = if _.isFunction(obj) then obj else require(obj)
  return template(data)



# application single point entry
module.exports = class Application
  @start: ->
    config = Backbone.Config.env()

    # getting page info
    body = document.body

    # user menu
    menu = try
      new UserMenuView
    catch
      null

    # getting an instance of page(controller)
    if controller = body.getAttribute('data-controller')
      Page = require "pages/#{controller.toLowerCase()}"
      page = new Page {name: controller, config: config}
      #return page.start()

    # getting an instance of an application(module)
    else if module = body.getAttribute('data-module')
      Module = require "modules/#{module.toLowerCase()}"
      module = new Module {name: module, config: config}
      return module.start()

    else
      console.info 'No controller or module was defined!'

