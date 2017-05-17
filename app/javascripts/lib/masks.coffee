"use strict"

# requires
TextMask        = require 'vanilla-text-mask'
TextMaskAddons  = require 'text-mask-addons'

###
#  Mask class
###
module.exports = class Mask

  # available mask list
  masks:
    zipcode: [/\d/, /\d/, /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/]


  # register masks
  register: (masks = [], options = {}) ->
    return if _.isEmpty masks

    # zipcode mask
    if _.contains masks, 'zipcode'
      for el in $('[data-mask="zipcode"]')
        TextMask.maskInput {
          inputElement: el, guide: false, mask: @masks['zipcode']
        }

    # phone mask
    if _.contains masks, 'phone'
      for el in $('[data-mask="phone"]')
        TextMask.maskInput {
          inputElement: el
          guide: false
          mask: ['(', /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d?/]
        }

    # date mask
    if _.contains masks, 'date'
      for el in $('[data-mask="date"]')
        TextMask.maskInput {
          inputElement: el, guide: false, mask: [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
        }

    # date month year mask
    if _.contains masks, 'month_year'
      for el in $('[data-mask="month_year"]')
        TextMask.maskInput {
          inputElement: el, guide: false, mask: [/\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
        }

    # number mask
    if _.contains masks, 'number'
      for el in $('[data-mask="number"]')
        pattern = TextMaskAddons.createNumberMask {allowDecimal: false, decimalSymbol: '', thousandsSeparatorSymbol: '', prefix: '', suffix: ''}
        TextMask.maskInput { inputElement: el, mask: pattern }

    # money mask
    if _.contains masks, 'money'
      for el in $('[data-mask="money"]')
        pattern = TextMaskAddons.createNumberMask {allowDecimal: true, decimalSymbol: ',', thousandsSeparatorSymbol: '.', decimalLimit: 2, requireDecimal:true}
        TextMask.maskInput { inputElement: el, mask: pattern }

