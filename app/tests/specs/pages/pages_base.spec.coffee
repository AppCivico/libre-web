"use strict"

# requires
Page = require 'pages/base'

class MockedBase extends Page


# begin test
describe Page.name, ->
  page = null
  mock = null

  # before each test
  beforeEach =>
    page = new Page
    mock = new MockedBase


  context 'self', ->
    it 'should be a correct instance', ->
      expect(page).to.be.instanceof Page


  describe "#el", ->
    it 'should have default valid element', ->
      expect(page.el).to.be.ok


  describe "#template", ->
    it 'should have template false as default', ->
      expect(page.template).to.be.false


  describe "#templates", ->
    it 'should be empty by default', ->
      expect(page.templates).to.be.empty


  describe "#errorList", ->
    it 'should be defined by default', ->
      expect(page.errorList).to.be.ok
        .and.a 'function'

    it 'should have some default errors', ->
      _.each {invalid: 'é inválido', required: 'é obrigatório'}, (value, key) ->
        expect(page.errorList(key)).to.be.equal(value)



