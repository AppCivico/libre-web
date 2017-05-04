"use strict"

# requires
Model = require 'models/register_donor'


# begin test
describe Model.name, ->
  model = null

  # before each test
  beforeEach =>
    model = new Model


  describe "#url", ->
    it 'should have correct endpoint', ->
      expect(model.url).to.be.equal('/register/donor')




