###
# FormMessage mixin class
# @author
###
module.exports = class FormMessage
  # clear form message
  clearFormMessage: ->
    $('.message').html ''
    return

  # render form message
  renderFormMessage: (stash = {}) ->
    template = require 'templates/message.eco'
    container = document.querySelector('#message')
    container.innerHTML = template(stash)
    return container

