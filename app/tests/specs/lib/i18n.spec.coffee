# requires
I18n = require 'lib/i18n.coffee'

# begin test
describe I18n.name, ->
  str = null

  beforeEach ->
    str = '''
      Ocorreu um erro não esperado no sistema. Uma mensagem ja foi enviada e analisaremos o
      problema.
    '''

  context '#property', ->
    it 'should be an hash of hash finishing by string message', ->
      p = I18n.property
      expect p.exception.default_message
        .to.be.an 'string'
        .that.is.equal str


  context '#t', ->
    it 'should return a string of an property using array as path', ->
      expect I18n.t ['exception', 'default_message']
        .to.be.equal str

    it 'should return a string of an property using string selector as path', ->
      expect I18n.t 'exception/default_message'
        .to.be.equal str



