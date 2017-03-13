
# defaults
@_datasets ?= {}
@_datasets.default = []

autocomplete_matcher = (list) ->
  return (q, cb) ->
    matches = []
    substrRegex = new RegExp(q, 'i')

    for str in list
      matches.push(str) if substrRegex.test(str)

    cb(matches)


@Typeahead =
  register: (element, options={}, params={})->
    $(element).typeahead(
      callback = params.callback || autocomplete_matcher
      options, {name:params.name, source:callback(params.dataset)}
    )
