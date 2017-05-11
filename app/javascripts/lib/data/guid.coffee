"use strict"


###
#  Guid class - simple random pseudo guid generator (from backbone.localStorage)
#  @author dvinciguerra
###
module.exports = class Guid

  @s4: ->
   (((1+Math.random())*0x10000)|0).toString(16).substring(1)

  @generate: ->
    ("#{@s4()+@s4()}-#{@s4()}-#{@s4()}-#{@s4()}-#{@s4()+@s4()+@s4()}").toUpperCase()

  @toString: ->
    @generate()
