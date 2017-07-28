
# requires
ModelBase = require 'models/base.coffee'

module.exports = class extends ModelBase
  url: '/donor/:user_id'


  # default attributes
  defaults:
    name: null
    surname: null
    cpf: null
    phone: null


  # events
  events:
    'change:user_id': 'onChangeUserId'


  onChangeUserId: (model, id) ->
    @url = @urlFor 'donor-user', user_id: id


  urlFor: (name, params = {}) ->
    if name is 'donor-user'
      return "#{@urlRoot}/donor/#{params.user_id}"


  # validate attributes
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # name validation (required; min: 2)
    if p.name?
      @setError 'name', 'invalid' unless p.name.length > 2
    else
      @setError 'name', 'required'

    # surname validation (require; min: 2)
    if p.surname?
      @setError 'surname', 'invalid' unless p.surname.length > 2
    else
      @setError 'surname', 'required'

    # phone validation (matchs: /^(99) 999999999?$/)
    if p.phone?
      @setError 'phone', 'invalid' unless p.phone.match /^\(\d{2}\) \d{4,5}\-\d{4}$/

    return @errors unless _.isEmpty(@errors.form_error)


  fetch: (params = {}) ->
    @set params
    return @request method: 'GET', data: @toJSON()


  update: (params = {}) ->
    @set params
    return @request method: 'PUT', data: @toJSON()


  # encode data to json
  toJSON: ->
    data =
      id: @get 'user_id'
      name: @get 'name'
      surname: @get 'surname'
      api_key: @get 'api_key'

    data.phone = (@get 'phone') if (@get 'phone')?
    data.cpf = (@get 'cpf') if (@get 'cpf')?

    # format phone
    if (@get 'phone')?
      phone = (@get 'phone').replace /[\(\)\s\-]/g, ''
      data.phone = "+55#{phone}"

    if (@get 'cpf')?
      data.cpf = (@get 'cpf').replace /[\.\-]/g, ''

    return data

