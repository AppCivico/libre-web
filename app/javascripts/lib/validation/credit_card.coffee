"use strict"

###
#  Validator class
#  @author dvinciguerra
###
module.exports = class CreditCardValidation

  @valid: (number = null) ->
    return true if @cardTypeFromNumber(number)?
    false


  @brandByNumber: (number = null) ->
    return null unless number?

    # Diners - Carte Blanche
    regex = /^30[0-5]/
    return "Diners - Carte Blanche" if number.match(regex)?

    # Diners
    regex = /^(30[6-9]|36|38)/
    return "Diners" if number.match(regex)?

    # JCB
    regex = /^35(2[89]|[3-8][0-9])/
    return "JCB" if number.match(regex)?

    # AMEX
    regex = /^3[47]/
    return "AMEX" if number.match(regex)?

    # Visa Electron
    regex = /^(4026|417500|4508|4844|491(3|7))/
    return "Visa Electron" if number.match(regex)?

    # Visa
    regex = /^4/
    return "Visa" if number.match(regex)?

    # Mastercard
    regex = /^5[1-5]/
    return "Mastercard" if number.match(regex)?

    # Discover
    regex = /^(6011|622(12[6-9]|1[3-9][0-9]|[2-8][0-9]{2}|9[0-1][0-9]|92[0-5]|64[4-9])|65)/
    return "Discover" if number.match(regex)?

    return null
