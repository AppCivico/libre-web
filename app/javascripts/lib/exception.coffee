"use strict"


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
    # TODO: Always check for new error
    # messages on https://github.com/eokoe/libre-api
    return switch token
      when 'invalid' then "é inválido"
      when 'required' then "é obrigatório"
      when 'empty_is_invalid' then "é obrigatório"
      when 'missing' then "é obrigatório"
      when 'alredy exists' then "já está cadastrado"
      when 'in_fucture' then "tem valor muito no futuro"
      when 'min_invalid' then "tem valor muito pequeno"
      when 'max_invalid' then "excede o tamanho máximo"
      when 'char_invalid' then "contém caracteres inválidos"
      when 'brand_invalid' then "deve ser de uma bandeira válida"
      when 'brand_required' then "não compatível com nenhuma bandeira"
      else ""

