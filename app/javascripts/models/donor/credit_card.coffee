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
    card_document: null
    card_name: null
    card_brand: null
    card_number: null
    card_validity: null
    card_csc: null

  # event bind
  events:
    'change:user_id': 'onChangeUserId'
    'change:card_number': 'onChangeCardNumber'


  # on change user id
  onChangeUserId: (model, user_id) ->
    @url = "#{@urlRoot}/donor/#{user_id}/credit-card"


  # on change card number
  onChangeCardNumber: (model, card_number) ->
    card_brand = @brandByNumber(card_number) or ''
    @set 'card_brand', card_brand.toLowerCase()


  # validate attributes
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # card name validation (required; min: 6)
    if p.card_name?
      @setError 'card_name', 'min_invalid' unless p.card_name.length > 5
      @setError 'card_name', 'max_invalid' unless p.card_name.length <= 26
      @setError 'card_name', 'char_invalid' unless p.card_name.match /^[A-Za-z\s]+$/
    else
      @setError 'card_name', 'required'

    # card document validation
    if p.card_document?
      unless p.card_document.match  /^\d{3}\.\d{3}\.\d{3}\-\d{2}$/
        @setError 'card_document', 'invalid'
    else
      @setError 'card_document', 'required'

    # card brand validation (required; metchs: visa, mastercard)
    if p.card_brand?
      brands = ['visa', 'mastercard']
      @setError 'card_number', 'brand_invalid' unless _.contains(brands, p.card_brand)
    else
      @setError 'card_number', 'brand_required'

    # card validity validation (required; matchs: 99/9999)
    if p.card_validity?
      @setError 'card_validity', 'invalid' unless p.card_validity.match /^\d{2}\/\d{4}$/
      #TODO: validate month range
      #TODO: validate year range
    else
      @setError 'card_validity', 'required'

    # card csc validation (required)
    if _.isEmpty p.card_csc
      @setError 'card_csc', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


  # override create method
  create: (options = {isCallback: false}) ->
    @url = "#{@urlRoot}/donor/#{@get('user_id')}/credit-card"
    Backbone.ajax {
      url: @url, method: 'POST', data: JSON.stringify(@toJSON options)
    }


  # make callback request (flotum)
  request_callback: (endpoint, params = {}) ->
    $.ajax {
      method: 'POST',
      url: endpoint or ''
      dataType : "json",
      contentType: "application/json; charset=utf-8",
      data: JSON.stringify(@toJSON {isCallback: true})
    }


  # get credit_card brand by checking card number
  brandByNumber: (number) ->
    CreditCardValidator.brandByNumber(number)


  # override to_json method
  toJSON: (options = {}) ->
    if _.has(options, 'isCallback') and options.isCallback is true
      dt = @get('card_validity').split('/') if @get 'card_validity'
      return {
        name_on_card: @get('card_name')
        csc: @get('card_csc')
        number: @get('card_number')
        validity: "#{dt[1] + dt[0]}"
        brand: (@get 'card_brand' or '')
        legal_document: @get('card_document')
      }
    else if _.has(options, 'isCallback') and options.isCallback is false
      return {
        api_key: @get('api_key')
        cpf: @get('card_document').replace /[\.\-]/g, ''
      }
    else
      return super options

