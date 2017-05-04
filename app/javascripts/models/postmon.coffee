"use strict"

module.exports = class PostmonModel extends Backbone.Model
  url: () ->
    return "http://api.postmon.com.br/cep/#{@attributes.zipcode}"

  default:
    zipcode: null



