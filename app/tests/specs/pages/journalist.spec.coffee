"use strict"

# requires
Page = require 'pages/join_us/journalist'


# begin test
describe Page.name, ->
  page = null

  # before each test
  beforeEach ->
    page = new Page

  describe '#template', ->
    it 'should be an existing page view component', ->
      expect(page.template).to.be.false


  describe '#getRegions', ->
    it 'should have journalist/vehicle data form', ->
      expect(page.getRegion 'form').to.be.ok
        .and.have.property('replaceElement')
        .and.equal(false)


