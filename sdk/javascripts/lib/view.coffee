# requires
Config = require 'config.coffee'
Session = require "lib/session.coffee"

###
# View Component class
###
module.exports = class
  el: null

  apiAddr: "//hapilibre.eokoe.com/api"

  webAddr: "//midialibre.org"

  constructor: (args = {}) ->
    @el = args.el || document.createElement('div')
    @settingConfig()

  session: ->
    Session.load()

  listenTo: (element, eventName, callback) ->
    element.addEventListener eventName, callback, false

  postMessage: (data = {}, origin = "*") ->
    json = JSON.stringify data
    window.parent.postMessage json, origin

  @windowParent: ->
    window.parent

  settingConfig: () ->
    @config = Config.all()
    @apiAddr =  @config.api
    @webAddr = @config.base



