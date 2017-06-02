'use strict'


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class PlanModel extends ModelBase
  url: "/donor/:user_id/plan"

  # default attributes
  defaults:
    user_id: 0
    amount: 2000


  # events
  events:
    'change:user_id': 'onChangeUserId'
    'change:amount': 'onChangeAmount'


  # constructor
  initialize: ->
    @set 'id', 1 # force PUT setting a fake id


  # set url when user_id is changed
  onChangeUserId: (model, user_id) ->
    @url = "#{@urlRoot}/donor/#{user_id}/plan"


  # clean amount when amount changes
  onChangeAmount: (model, amount) ->
    amount = amount.replace(',', '').replace('.', '')
    @set 'amount', amount


  # validate attributes
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # email validation (required; matchs: /\@/)
    if p.amount?
      @setError 'amount', 'invalid' unless p.amount >= 2000
    else
      @setError 'amount', 'required'

    return @errors unless _.isEmpty(@errors.form_error)


  # save plan using always PUT method
  save: ->
    @url = "#{@urlRoot}/donor/#{@get('user_id')}/plan"
    super arguments


