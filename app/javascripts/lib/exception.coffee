# requires
I18n = require "lib/i18n.coffee"

###
#  Exception class
#  @author dvinciguerra
###
module.exports = class Exception

  # token to human friendly error message
  @humanize: (token) ->
    @getMessage token

  # error messages
  @getMessage: (token) ->
    message = null
    try
      message = I18n.t "exception/#{token}"
    catch e
      message = ''

    message

  @throws: (message, options = {}) ->
    throw new Error message
