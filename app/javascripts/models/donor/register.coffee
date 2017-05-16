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


