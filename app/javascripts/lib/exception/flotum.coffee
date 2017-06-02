'use strict'

# requires
#ExceptionBase = require 'lib/exception/base'


###
#  Flotum Exception class
#  @author dvinciguerra
###
module.exports = class FlotumException #extends ExceptionBase

  # token to human friendly error message
  @humanize: (token = null) ->
    switch token
      when 'validity_credit_card_already_expired' then 'Cartão com validade vencida'
      else 'Erro ao cadastrar cartão de crédito'
