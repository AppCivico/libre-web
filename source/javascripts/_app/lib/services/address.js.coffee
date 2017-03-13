App.Service ?= {}

class App.Service.Address
  @get: (cep) ->
    $.ajax {
      url: "http://api.postmon.com.br/v1/cep/#{cep}"
      dataType: 'json'
    }
