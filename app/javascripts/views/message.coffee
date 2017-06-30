# requires
ViewBase = require 'views/base.coffee'

###
#  View class
#  @author dvinciguerra
###
module.exports = class Message extends ViewBase
  template: false

  # constructor
  initialize: () ->


  show: (args = {}) ->
    title = args.title or ''
    content = args.content or ''

    # native
    alert args.content or ''


  @show: (args = {})->
    message = new (this)
    message.show args
