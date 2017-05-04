"use strict"


# requires
ModelBase = require 'models/base.coffee'


###
#  Model class
#  @author dvinciguerra
###
module.exports = class RegisterDonorModel extends ModelBase

  # default endpoints
  url: '/register/donor'


  # create model
  create: (params = {}, options = {}) ->
    options.method = 'POST'
    options.type = 'json'
    options.data = _.extend @attributes, params
    options.url = options.url ? "#{@urlRoot}#{@url}"
    @request(options)


