"use strict"


###
#  View base class
#  @author dvinciguerra
###
module.exports = class ViewBase extends Marionette.View
  el: document.body

  # stash variable
  stash: {}

  setRenderer: (template, data, view) ->
    data = _.extend(data, {stash: view.stash})

    template = if _.isFunction(obj) then obj else require(obj)
    return template(data)
