# requires
Model = require 'models/session.coffee'

# FIXME: create some factories
# FACTORIES
class Factory
  @factories:
    signin:
      type: "signin"
      email: "test@test.com"
      password: "test"

    forgot:
      type: "forgot"
      email: "test@test.com"

    reset:
      type: "reset"
      new_password: "test"
      token: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"

  @create = (name, params = {}) ->
    factory = @factories[name] || {}
    factory = _.extend factory, params
    return factory




# begin test
describe Model.name, ->
  model = null

  # before each test
  beforeEach ->
    model = new Model


  context 'self', ->
    it 'should be instanceof ModelBase', ->
      expect(model).to.be.instanceof Model


  context "attributes", ->
    it 'should return email and password for signin type', ->
      params = Factory.create 'signin'
      model.set params
      expect(model.toJSON()).to.be.eql {email: params.email, password: params.password}

    it 'should return email and password for forgot type', ->
      params = Factory.create 'forgot'
      model.set params
      expect(model.toJSON()).to.be.eql {email: params.email}

    it 'should return email and password for reset type', ->
      params = Factory.create 'reset'
      model.set params
      expect(model.toJSON()).to.be.eql {new_password: params.new_password, token: params.token}


  context "validations", ->
    it 'should return validate attributes for signin type', ->
      model.set Factory.create 'signin', {email: null}
      expect(model.isValid()).to.be.false

    it 'should return validate attributes for forgot type', ->
      model.set Factory.create 'forgot', {email: null}
      expect(model.isValid()).to.be.false

    it 'should return validate attributes for reset type', ->
      model.set Factory.create 'reset', {email: null}
      expect(model.isValid()).to.be.false


  context "model methods", ->
    it '#authenticate', ->
      expect(model).to.respondTo 'authenticate'

    it '#forgotPassword', ->
      expect(model).to.respondTo 'forgotPassword'

    it '#resetPassword', ->
      expect(model).to.respondTo 'resetPassword'




