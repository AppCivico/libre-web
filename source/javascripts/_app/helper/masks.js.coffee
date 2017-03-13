#NAME
#  Input Mask Helper
#
#DESCRIPTION
#  This helper configure some input field masks
#
#SINOPSYS
#
#  # get mask object
#  masker = MaskHelper
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra

# mask helper (uses VMasker as default)

try
  @MaskHelper = VMasker

  # register custom masks
  @MaskHelper.register_masks = ($parent) ->

    ## mask for numbers
    $list = $parent.find '*[data-mask=number]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskNumber()

    ## mask for money
    $list = $parent.find '*[data-mask=money]'
    if $list.length > 0
      options = precision: 2, separator: ',', delimiter: '.', unit: 'R$', suffixUnit: '', zeroCents: true
      $list.map (i, el) -> VMasker(el).maskMoney(options)

    ## mask for date
    $list = $parent.find '[data-mask=date]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskPattern "99/99/9999"

    ## mask for cpf
    $list = $parent.find '[data-mask=cpf]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskPattern "999.999.999-99"

    ## mask for cnpj
    $list = $parent.find '[data-mask=cnpj]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskPattern "99.999.999/9999-99"

    ## mask for phone
    $list = $parent.find '[data-mask=phone]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskPattern "(99) 999999999"

    ## mask for number
    $list = $parent.find '[data-mask=number]'
    if $list.length > 0
      $list.map (i, el) -> VMasker(el).maskNumber()

catch e
  console.error e.message
