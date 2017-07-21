"use strict"

module.exports = class PostmonModel extends Backbone.Model
  url: () ->
    return "https://api.postmon.com.br/cep/#{@attributes.zipcode}"

  default:
    zipcode: null



