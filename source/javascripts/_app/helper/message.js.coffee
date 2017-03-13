#NAME
#  Message Helper
#
#DESCRIPTION
#  This helper provide a simple wrapper to show user messages
#
#SINOPSYS
# 
#  # simple message
#  message 'This is the message'
#
#  # message and title
#  message 'This is the title', 'and I\'m the message'
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra


# message helper
@message = (title, message, options = {}) ->
  if typeof(swal) isnt 'undefined'
    # alert (using sweet-alert)
    swal(title) if title and not message
    swal(title, message) if title and message
  else
    # alert (using native method)
    alert title

