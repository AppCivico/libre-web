"use strict"

# requires
Guid = require 'lib/data/guid.coffee'


# begin test
describe Guid.name, ->
  object = Guid

  context '.generate()', ->
    it 'should return a random pseudo guid', ->
      guid = object.generate()
      expect(guid).to.be.ok

    it 'should return a string in a specific format', ->
      [1 .. 20].forEach (x) =>
        guid = object.generate()
        expect(guid).to.match /^([A-F0-9]{8})-([A-F0-9]{4})-([A-F0-9]{4})-([A-F0-9]{4})-([A-F0-9]{12})$/
        expect(guid).to.have.lengthOf 36

