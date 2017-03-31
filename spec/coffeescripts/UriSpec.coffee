###
# URI helper
###
describe 'URIHelper', ->
  uri = null

  beforeEach ->
    uri = URI.init('https://www.google.com')

  it 'does uri defined', ->
    expect(uri).toBeDefined()

  it 'does uri location defined', ->
    expect(uri._location).toEqual("https://www.google.com")
    expect(uri.absolute()).toEqual("https://www.google.com")

