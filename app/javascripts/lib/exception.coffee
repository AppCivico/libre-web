"use strict"


###
#  Exception class
#  @author dvinciguerra
###
module.exports = class Exception

  # error messages
  @getMessage: (token) ->
    # TODO: Always check for new error messages on https://github.com/eokoe/libre-api
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      when 'missing' then "é obrigatório"
      when 'alredy exists' then "já está cadastrado"
      else ""

