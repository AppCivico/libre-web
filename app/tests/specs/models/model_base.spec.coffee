# requires
Model = require 'models/base'

class MockedBase extends Model


# begin test
describe Model.name, ->
  model = null
  mock = null

  # before each test
  beforeEach ->
    model = new Model
    mock = new MockedBase


  context 'self', ->
    it 'should be instanceof ModelBase', ->
      expect(model).to.be.instanceof Model


  describe "#request", ->
    it 'should have the method', ->
      expect(model).to.have.property 'request'


  describe "#urlRoot", ->
    it 'should be defined and valid', ->
      expect(model.urlRoot).to.be.ok
        .and.match /[eokoe|libre].com/



