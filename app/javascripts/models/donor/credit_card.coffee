"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class CreditCardModel extends ModelBase

  # default endpoints
  url: "/donor/#{@id || 0}/credit-card"

  # constructor
  initialize: () ->
    @on 'change:id', (model, id) =>
      @url = "/donor/#{@id || 0}/credit-card"



