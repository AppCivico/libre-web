# requires
ViewBase = require 'views/base.coffee'
Loading = require 'views/loading.coffee'
Message = require 'lib/message.coffee'
UserModel = require 'models/donor/user.coffee'
Masks = require 'lib/masks.coffee'


module.exports = class extends ViewBase
  el: "section#dash-main"
  template: 'templates/dash/collaborator/form.eco'

  model: new UserModel

  ui:
    form: '#user-form'

  events:
    'submit @ui.form': 'submitForm'

  initialize: ->
    @loading = new Loading
    @loading.show()


  submitForm: (event) ->
    event.preventDefault()

    @model.update @userParams()
      .done (res) ->
        Message.show
          type: 'success'
          title: 'Sucesso'
          message: 'Informações atualizadas!'

        setTimeout ->
          document.location = '/app'
        , 1000


      .fail (res) ->
        Message.show
          type: 'danger'
          title: 'Ops!'
          message: 'Não foi possível atualizar seu plano!'

    return false


  onRender: ->
    masks = new Masks
    masks.register ['cpf', 'phone']

    @model.fetch @userParams()
      .done (json) =>
        @model.set json || {}
        @setParams()

      .fail (res) ->
        Message.show
          type: 'danger'
          title: 'Ops!'
          message: 'Não foi possível carregar suas informações!'


    @loading.hide()


  setParams: (params = {}) ->
    ($ 'input[name=name]').val @model.get 'name'
    ($ 'input[name=surname]').val @model.get 'surname'

    phone = @model.get 'phone'
    if phone?
      groups = phone.match /^\+55(\d{2})(\d{4,5})(\d{4})$/
      ($ 'input[name=phone]').val "(#{groups[1]}) #{groups[2]}-#{groups[3]}"

    cpf = @model.get 'cpf'
    if cpf?
      groups = cpf.match /^(\d{3})(\d{3})(\d{3})(\d{2})$/
      ($ 'input[name=cpf]').val "#{groups[1]}.#{groups[2]}.#{groups[3]}-#{groups[4]}"

  userParams: (params = {}) ->
    data =
      user_id: @session.get 'user_id'
      api_key: @session.get 'api_key'
      name: ($ 'input[name=name]').val()
      surname: ($ 'input[name=surname]').val()
      phone: ($ 'input[name=phone]').val() || null
      cpf: ($ 'input[name=cpf]').val() || null
    return data
