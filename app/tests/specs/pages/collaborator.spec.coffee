"use strict"

# requires
Page = require 'pages/join_us/collaborator'


# begin test
describe Page.name, ->
  page = null

  # before each test
  beforeEach ->
    page = new Page


  describe "#template", ->
    it 'should be an existing page view component', ->
      expect(page.template).to.be.false


  describe "#getRegions", ->
    it 'should have personal data form', ->
      expect(page.getRegion 'personal').to.be.ok
        .and.have.property 'el'
        .and.equal 'form#personal-form'

    it 'should have plan data form', ->
      expect(page.getRegion 'plan').to.be.ok
        .and.have.property 'el'
        .and.equal 'form#plan-form'

    it 'should have billing data form', ->
      expect(page.getRegion 'billing').to.be.ok
        .and.have.property 'el'
        .and.equal 'form#billing-form'


