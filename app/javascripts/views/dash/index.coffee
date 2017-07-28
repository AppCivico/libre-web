
# requires
ViewBase = require 'views/base.coffee'
Loading = require 'views/loading.coffee'

module.exports = class extends ViewBase
  regions:
    main: "section#dash-main"


  initialize: ->
    @loading = new Loading
    @loading.show()

    View = null
    current = @session.get 'current'

    if current is 'donor'
      View = require 'views/dash/collaborator/index.coffee'

    else if current is 'journalist'
      View = require 'views/dash/journalist/index.coffee'

    else
      throw new Error 'Current prop for logged in user is invalid'

    @showChildView 'main', (new View).render()

