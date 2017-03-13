# namespace
@App ?= {}

###
# Class for Util functions
###
class App.Util

  # parse perl DateTime string
  @parse_datetime: (str) ->
    return null unless str?
    if d = str.match(/^(\d{4})-(\d{2})-(\d{2})/)
      new Date("#{d[1]}-#{d[2]}-#{d[3]}")

