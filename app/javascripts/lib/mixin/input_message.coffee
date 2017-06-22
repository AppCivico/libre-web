###
#  InputMessages mixin class
#  @author dvinciguerra
###
module.exports = class InputMessages

  # clear input messages
  clearInputMessages: ->
    $('small.input-message').remove()
    $('.has-error').toggleClass 'has-error'
    return


  # render input message
  renderInputMessages: ($form = null, stash = {}) ->
    template = require 'templates/input_message.eco'
    @clearInputMessages()

    for key, value of stash
      $el = $form.find "[name=#{key}]"
      placeholder = $el.attr 'placeholder'

      $el.parent()
        .addClass 'has-error'
        .append(template {content: @setInputMessage(placeholder, value)})


  # format input message
  setInputMessage: (field, value) =>
    return "#{field} #{@errorList(value)}"


