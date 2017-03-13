#NAME
#  Confirmable Helper
#
#DESCRIPTION
#  This helper provide a simple wrapper to show user messages
#  to confirm or not
#
#SINOPSYS
#
#  # simple confirm
#  confirmable {
#    # text to be presented
#    text: 'This is the message'
#
#    # ok button press
#    success: ->
#      message 'This is a success message'
#
#    # cancel button press
#    cancel: ->
#      message 'Canceled by user'
#  }
#
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra

# alert helper
try
  @confirmable = (options = {}) ->
    if typeof(swal) isnt 'undefined'
      # alert (using sweet-alert)
      ok_cb = options.success || ->
      cancel_cb = options.cancel || ->

      # default option
      options.showCancelButton  = true
      options.confirmButtonText = options.confirmButtonText || "OK"
      options.cancelButtonText  = options.cancelButtonText  || "Cancelar"

      unless options.title
        options.title = options.text
        delete options.text

      swal options, (is_confirm) ->
        if is_confirm
          ok_cb()
        else
          cancel_cb()

    else
      # alert (using native method)
      if confirm(options.text)
        ok_cb()
      else
        cancel_cb()

catch e
  console.error(e.message)
