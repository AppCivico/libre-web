
###
#  Message class
#  @author dvinciguerra
###
module.exports = class

  # get container element
  @getElement: ->
    $ '.message'

  @getAllClasses: ->
    "alert alert-info alert-warning alert-success alert-danger"

  # clear messages
  @clear: (params = {}) ->
    data = @defaultParams params
    data.element
      .removeClass @getAllClasses()
      .html ""

  # show messages
  @show: (params = {}) ->
    data = @defaultParams params

    data.element
      .removeClass @getAllClasses()
      .addClass "alert #{data.type}"
      .html """
        #{data.title}
        #{data.message}
      """

  # prepare params
  @defaultParams: (params = {}) ->
    data = {}
    data.element  = params.element ? @getElement()
    data.type     = if params.type? then "alert-#{params.type}" else "alert-info"
    data.title    = if params.title? then "<h4>#{params.title}</h4>" else ""
    data.message  = params.message ? ""
    return data

