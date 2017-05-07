"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class PlanModel extends ModelBase

  # default endpoints
  url: "/donor/#{@id || 0}/plan"

  # constructor
  initialize: () ->
    @on 'change:id', (model, id) =>
      @url = "/donor/#{@id || 0}/plan"



