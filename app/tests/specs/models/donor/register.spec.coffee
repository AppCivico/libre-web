"use strict"

# requires
Model = require 'models/donor/register'


# begin test
describe Model.name, ->
  model = null

  # before each test
  beforeEach ->
    model = new Model


  describe "#url", ->
    it 'should have correct endpoint', ->
      expect model.url
        .to.match /register\/donor/




