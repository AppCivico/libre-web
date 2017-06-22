# requires
Utils = require 'lib/utils.coffee'

# begin test
describe Utils.name, ->

  context '.random', ->
    it 'should be a number between 0 and 100', ->
      expect Utils.random 0, 100
        .to.be.least 0
        .and.most 100


  context '.stringify', ->
    it 'should return a string of an object', ->
      str = Utils.stringify {name: 'foo'}
      expect str
        .to.be.eq "{\"name\":\"foo\"}"


  context '.escapeHTML', ->
    it 'should return escaped html string', ->
      expect Utils.escapeHTML '<a>Link</a>'
        .to.be.eq '&lt;a&gt;Link&lt;/a&gt;'


  context '.unescapeHTML', ->
    it 'should return escaped html string', ->
      expect Utils.unescapeHTML '&lt;a&gt;Link&lt;/a&gt;'
        .to.be.eq '<a>Link</a>'
