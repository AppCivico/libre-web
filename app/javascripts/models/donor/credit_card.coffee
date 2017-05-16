"use strict"


# requires
ModelBase = require 'models/base.coffee'
CreditCardValidator = require 'lib/validation/credit_card.coffee'

###
#  Model class
#  @author dvinciguerra
###
module.exports = class CreditCardModel extends ModelBase
  url: "/donor/:user_id/credit-card"

  # default attributes
  defaults:
    user_id: 0
    cpf: 0


  # constructor
  initialize: ->
    # attribute events
    @on 'change:user_id', (model, user_id) =>
      @url = "#{@urlRoot}/donor/#{user_id}/credit-card"

    @on 'change:card_number', (model, card_number) =>
      card_brand = @brandByNumber(card_number) or ""
      @set 'card_brand', card_brand.toLowerCase()



  # override create method
  create: (options = {isCallback: false}) ->
    Backbone.ajax {
      url: @url, method: 'POST', data: JSON.stringify @toJSON(options)
    }

  # make callback request (flotum)
  request_callback: (endpoint, params = {}) ->
    console.log arguments
    console.log JSON.stringify @toJSON({isCallback: true})
    $.ajax {
      method: 'POST',
      url: endpoint or ''
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify @toJSON({isCallback: true})
    }


  # get credit_card brand by checking card number
  brandByNumber: (number) ->
    CreditCardValidator.brandByNumber(number)


  # override to_json method
  toJSON: (options = {}) ->
    if _.has(options, 'isCallback') and options.isCallback is true
      dt = @get('card_validity').split('/')
      return {
        name_on_card: @get('card_name')
        csc: @get('card_csc')
        number: @get('card_number')
        validity: "#{dt[1] + dt[0]}"
        brand: (@get('card_brand') || '')
        legal_document: @get('card_document')
      }
    else if _.has(options, 'isCallback') and options.isCallback is false
      return {
        api_key: @get('api_key')
        cpf: @get('card_document')
      }
    else
      return super options

