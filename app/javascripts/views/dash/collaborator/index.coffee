
# requires
ViewBase = require 'views/base.coffee'
Loading = require 'views/loading.coffee'
SupportModel = require 'models/donor/support.coffee'

module.exports = class extends ViewBase
  el: 'section#dash-main'
  template: 'templates/dash/collaborator/index.eco'

  model: new SupportModel

  initialize: ->
    @loading = new Loading
    @loading.show()


  render: ->
    @model.set @supportParams()
    @model.findSupports()
      .done (res) =>
        res ?= []
        @stash 'supports', res

      .always (res) =>
        super()

    super()


  onRender: ->
    @loading.hide()


  supportParams: ->
    session = @session.get()
    return {
      api_key: session.api_key
      donor_id: session.user_id
    }
