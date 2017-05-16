"use strict"

# requires

module.exports = class Utils

  # random int with min and max options
  @random: (min, max) ->
    return Math.floor(Math.random()) unless min? and max?
    return Math.floor(Math.random() * (max - min)) + min


  # object stringify
  @stringify: (object = null) ->
    if object? then JSON.stringify(object) else null


  # encode url
  @escapeURL: (str = null) ->
    encodeURI(str)


  # decode url
  @unescapeURL: (str = null) ->
    decodeURI(str)


  # encode html strings
  @escapeHTML: (str = '') ->
    unless html.legth > 0 and typeof html is 'string'
      console.warn 'An empty html string passed as param'
    str.replace '<', '&lt;'
      .replace '>', '&gt;'


  # decode html strings
  @unescapeHTML: (str = '') ->
    unless html.legth > 0 and typeof html is 'string'
      console.warn 'An empty html string passed as param'
    str.replace '&lt;', '<'
      .replace '&gt;', '>'


