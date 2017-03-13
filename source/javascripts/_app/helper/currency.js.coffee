#NAME
#  Puts Helper
#
#DESCRIPTION
#  This helper provide a simple implementation o ruby puts to output data
#
#SINOPSYS
#
#  # output string
#  puts "Hello world"
#
#  # output array data-structure
#  puts [1, 2, 3]
#
#  # output object
#  puts {name: 'joe', last_name: 'Doe'}
#
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra


###*
# BrazilianCurrency helper
# Format a number using brazilian currency
###
@Currency = (value) ->
  return {
    amount: value
    format: (@options={}) ->
      amount = (@amount / 100).toFixed(2)
      reals = amount.split(/\./)[0]
      cents = amount.split(/\./)[1]
      formated = []
      salts = 0
      numbers = reals.split('').reverse()
      for i in  numbers
        formated.push(i)
        if salts is 2
          formated.push "." if i isnt (reals.length + 1)
          salts = 0
          continue

        salts++

      formated = formated.reverse()
      formated.shift() if formated[0] is '.'
      formated = "#{formated.join('')},#{cents}"

      return "R$ #{formated}" if @options and @options.symbol is true
      "#{formated}"
  }

