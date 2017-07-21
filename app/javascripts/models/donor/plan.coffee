
# requires
ModelBase = require 'models/base.coffee'


module.exports = class extends ModelBase
  url: "/donor/:user_id/plan"

  # defaults
  defaults:
    user_id: 0
    amount: 2000


  # events
  events:
    'change:user_id': 'onChangeUserId'
    'change:amount': 'onChangeAmount'


  onChangeUserId: (model, user_id) ->
    @url = "#{@urlRoot}/donor/#{user_id}/plan"


  onChangeAmount: (model, amount) ->
    if typeof amount is 'string'
      amount = (amount.replace ',', '').replace '.', ''
    @set 'amount', amount


  # methods
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # email validation (required; matchs: /\@/)
    if p.amount?
      @setError 'amount', 'invalid' unless p.amount >= 2000
    else
      @setError 'amount', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


  save: ->
    @url = "#{@urlRoot}/donor/#{@get('user_id')}/plan"
    @url += "/#{@get 'id'}" if (@get 'id')?
    super arguments


  fetch: (params = {amount: 0}) ->
    @set params
    return $.ajax
      url: @url
      data: @attributes
      dataType: 'json'

