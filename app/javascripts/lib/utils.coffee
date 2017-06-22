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
    unless str.length > 0 and typeof str is 'string'
      console.warn 'An empty html string passed as param'
    str.replace /\</g, '&lt;'
      .replace /\>/g, '&gt;'


  # decode html strings
  @unescapeHTML: (str = '') ->
    unless str.length > 0 and typeof str is 'string'
      console.warn 'An empty html string passed as param'
    return str.replace /&lt;/g, '<'
      .replace /&gt;/g, '>'


