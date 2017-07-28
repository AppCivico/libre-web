
# requires
Alertify = require 'alertify.js'


module.exports = class

  show: (args = {}) ->
    title = args.title or ''
    content = args.content or ''

    # native
    if Alertify?
      Alertify.alert args.content || ''
    else
      alert args.content || ''


  @show: (args = {})->
    message = new (this)
    message.show args

  @confirm: (args = {})->
    confirmCb = (args.confirm ? ->)
    cancelCb = (args.cancel ? ->)
    Alertify.confirm args.content, confirmCb, cancelCb

  @success: (args = {})->
    Alertify.logPosition "top left"
    Alertify.success args.content

