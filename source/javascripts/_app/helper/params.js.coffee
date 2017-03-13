#NAME
#  Params Helper
#
#DESCRIPTION
#  This helpers dev to get params from the form and return a
#  param object
#
#SINOPSYS
#
#   # getting from form (can use selectors)
#   params = Params
#     .form 'form_name'
#     .permit ['email', 'password', 'remember_info']
#
#   # returning an object
#   params.to_h
#
#   # returning an json
#   params.to_json
#
#
#AUTHOR
#  Daniel Vinciguerra @dvinciguerra

# params helper
try
  @Params =
    ###
      class attributes
    ###
    _form: null
    _fields: {}


    ###
     class methods
    ###

    # load form element
    form: (obj=null) ->
      if obj? and typeof(obj) is 'string'
        @_form = document.querySelector(obj) || null
      if obj? and typeof(obj) is 'object'
        @_form = obj || null
      this

    # set fields that you want to work
    permit: (fields) ->
      if @_form
        for f in fields then @_fields[f] = @_form.elements[f]
      this

    # return a hash/json with params
    to_h: () ->
      fields = {}
      if @_fields
        for key, $input of @_fields then fields[key] = $input.value || ""
      fields

    # return a form_data with params
    to_data: () ->
      fdata = new FormData()
      if @_fields
        for key, $input of @_fields
          if $input? and $input.type is 'file'
            fdata.append(key, $input.files[0]) if $input.files[0]
          else if $input?
            fdata.append(key, $input.value)

      fdata

    # return a query_string with params
    to_s: ->
      buffer = []
      params = @to_h()

      for name, value of params
        value_encoded = encodeURIComponent value || ""
        buffer.push "#{encodeURIComponent(name)}=#{value_encoded}" if name?

      buffer.join("&").replace /%20/g, "+"

catch e
  console.error e.message
