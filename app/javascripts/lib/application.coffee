"use strict"

# configuration
Config = require 'config.coffee'
Backbone.Config = Config
Backbone.Config.environment = 'development' # 'production'


# Backbone.ajax hack for resources with our perl api
# (force data, content_type and process_data)
_backboneAjax = Backbone.ajax
Backbone.ajax = (options = {}) ->
  options.data = JSON.parse(options.data)
  options.contentType = 'application/x-www-form-urlencoded'
  options.processData = true
  return _backboneAjax(options)


# config renderer
Marionette.Renderer.render = (obj, data, view) ->
  data = _.extend(data, {stash: view.stash})

  template = if _.isFunction(obj) then obj else require(obj)
  return template(data)



# application single point entry
module.exports = class Application
  @start: ->
    config = Backbone.Config.env()

    # getting page info
    body = document.body

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

