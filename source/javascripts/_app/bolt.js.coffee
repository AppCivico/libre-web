# namespace
@App = @App || {}


#############################
# Application base class
#############################
class @Application
  @init = ->
    try
      [$body, ctrl, act] = @_get_vars()

      # check if action and controller exists
      ns = App.Controller
      if ns[ctrl] and ns[ctrl][act] and 'function' is typeof(ns[ctrl][act])
        new App.Controller[ctrl][act](controller: ctrl, action: act)

    catch e
      # show error
      console.error(e)


  # getting startup variables
  @_get_vars: ->
    $body = $(document.body)
    [$body, $body.data('controller'), $body.data('action') or 'index']





