
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
    @url = @urlFor 'plan', user_id: user_id


  onChangeAmount: (model, amount) ->
    if typeof amount is 'string'
      amount = (amount.replace ',', '').replace '.', ''
    @set 'amount', amount


  urlFor: (name, params = {}) ->
    if name is 'plan'
      return "#{@urlRoot}/donor/#{params.user_id}/plan"

    if name is 'plan_cancel'
      return "#{@urlRoot}/donor/#{params.user_id}/plan/#{params.id}/cancel"


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
    @url = @urlFor 'plan', user_id: (@get 'user_id')
    @url += "/#{@get 'id'}" if (@get 'id')?
    @unset 'id' if @get 'canceled' is 1
    super @toJSON()


  fetch: (params = {amount: 0}) ->
    @set params
    return $.ajax
      url: @url
      data: @attributes
      dataType: 'json'


  cancelPlan: (params = {}) ->
    @url = @urlFor 'plan_cancel', user_id: (@get 'user_id'), id: (@get 'id')
    return $.ajax
      url: @url
      method: 'POST'
      data: @attributes
      dataType: 'json'


  toJSON: ->
    return {
      id: @get 'id'
      user_id: @get 'user_id'
      amount: @get 'amount'
      api_key: @get 'api_key'
    }


