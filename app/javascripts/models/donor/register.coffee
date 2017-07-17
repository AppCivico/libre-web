"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class RegisterDonorModel extends ModelBase
  url: '/register/donor'


  # default attributes
  defaults:
    email: null
    password: null
    name: null
    surname: null


  # validate attributes
  validate: (p = {}, settings = {}) ->
    @errors = {form_error: {}}

    # email validation (required; matchs: /\@/)
    if p.email?
      @setError 'email', 'invalid' unless p.email.match /\@/
    else
      @setError 'email', 'required'

    # password validation (required; min: 4)
    if p.password?
      @setError 'password', 'invalid' unless p.password.length >= 4
    else
      @setError 'password', 'required'

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

    # cpf validation (matchs: /^(99) 999999999?$/)
    if p.cpf?
      @setError 'cpf', 'invalid' unless p.cpf.match /^\d{3}\.\d{3}\.\d{3}\-\d{2}$/
    else
      @setError 'cpf', 'required'

    # phone validation (matchs: /^(99) 999999999?$/)
    if p.phone?
      @setError 'phone', 'invalid' unless p.phone.match /^\(\d{2}\) \d{8,9}$/

    return @errors unless _.isEmpty(@errors.form_error)


  # encode data to json
  toJSON: ->
    data =
      email: @get('email')
      password: @get('password')
      name: @get('name')
      surname: @get('surname')

    # format phone
    if @get('phone')?
      phone = @get('phone').replace /[\(\)\s]/g, ''
      data.phone = "+55#{phone}"

    return data

