# requires
Session = require "lib/session.coffee"

###
# View Component class
###
module.exports = class
  el: null

  constructor: (args = {}) ->
    @el = args.el || document.createElement('div')
    @config = args.config || {}

  config: ->
    @config

  session: ->
    Session.load()

  listenTo: (element, eventName, callback) ->
    element.addEventListener eventName, callback, false

  postMessage: (data = {}, origin = "*") ->
    json = JSON.stringify data
    window.parent.postMessage json, origin

  @windowParent: ->
    window.parent


