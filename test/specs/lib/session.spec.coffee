"use strict"

# requires
Session = require 'lib/session'


# begin test
describe Session.name, ->
  object = null

  # before each test
  beforeEach =>
    object = new Session


  context 'self', ->
    it 'should be instanceof Session', ->
      expect(object).to.be.instanceof Session


  context '#attributes', ->
    it 'should have default attributes', ->
      expect(object.attributes).to.include.keys ['api_key', 'roles', 'user_id']


  context '#set()', ->
    it 'should not have a default key', ->
      expect(object.attributes).to.not.have.property 'foo'

    it 'should set key and value', ->
      object.set 'foo', 'bar'
      expect(object.attributes).to.have.property 'foo'
      expect(object.attributes.foo).to.be.equal 'bar'

    it 'should set key and a null value', ->
      object.set 'foo', null
      expect(object.attributes.foo).to.be.null

    it 'should set key and a bool value', ->
      object.set 'foo', true
      expect(object.attributes.foo).to.be.true

    it 'should set all when key is an object', ->
      object.set {name: 'foo', surname: 'bar'}
      expect(object.attributes).to.have.property 'name'
        .that.is.equal 'foo'
      expect(object.attributes).to.have.property 'surname'
        .that.is.equal 'bar'

  context '#get()', ->
    it 'should not have a default key', ->
      expect(object.attributes).to.not.have.property 'foo'

    it 'should get value from key', ->
      object.set 'foo', 'bar'
      value = object.get 'foo'
      expect(value).to.be.equal 'bar'


  context '#storageName()', ->
    it 'should return the storage name', ->
      expect(object.storageName()).to.be.equal 'localStorage'



