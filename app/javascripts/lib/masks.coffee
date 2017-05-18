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
    zipcode:    [/\d/, /\d/, /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/]
    phone:      ['(', /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d/, /\d?/]
    date:       [/\d/, /\d/, '/', /\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
    month_year: [/\d/, /\d/, '/', /\d/, /\d/, /\d/, /\d/]
    number:     TextMaskAddons.createNumberMask {
      allowDecimal: false, decimalSymbol: '', thousandsSeparatorSymbol: '', prefix: '', suffix: ''
    }
    money:      TextMaskAddons.createNumberMask {
      allowDecimal: true, decimalSymbol: ',', thousandsSeparatorSymbol: '.', decimalLimit: 2, requireDecimal:false, prefix: '', suffix: ''
    }


  # register masks
  register: (masks = [], options = {}) ->
    # zipcode mask
    if _.contains masks, 'zipcode'
      for el in $('[data-mask="zipcode"]')
        TextMask.maskInput inputElement: el, guide: false, mask: @masks['zipcode']

    # phone mask
    if _.contains masks, 'phone'
      for el in $('[data-mask="phone"]')
        TextMask.maskInput inputElement: el, guide: false, mask: @masks['phone']

    # date mask
    if _.contains masks, 'date'
      for el in $('[data-mask="date"]')
        TextMask.maskInput inputElement: el, guide: false, mask: @masks['date']

    # date month year mask
    if _.contains masks, 'month_year'
      for el in $('[data-mask="month_year"]')
        TextMask.maskInput inputElement: el, guide: false, mask: @masks['month_year']

    # number mask
    if _.contains masks, 'number'
      for el in $('[data-mask="number"]')
        TextMask.maskInput inputElement: el, mask: @masks['number']

    # money mask
    if _.contains masks, 'money'
      for el in $('[data-mask="money"]')
        TextMask.maskInput inputElement: el, mask: @masks['money'], guide: true
