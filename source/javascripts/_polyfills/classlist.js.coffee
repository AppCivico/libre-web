
# Source: https://gist.github.com/k-gun/c2ea7c49edf7b757fe9561ba37cb19ca
do ->
  regExp = (name) ->
    new RegExp('(^| )' + name + '( |$)')

  forEach = (list, fn, scope) ->
    i = 0
    while i < list.length
      fn.call scope, list[i]
      i++
    return

  # class list object with basic methods

  ClassList = (element) ->
    @element = element
    return

  ClassList.prototype =
    add: ->
      forEach arguments, ((name) ->
        if !@contains(name)
          @element.className += ' ' + name
        return
      ), this
      return

    remove: ->
      forEach arguments, ((name) ->
        @element.className = @element.className.replace(regExp(name), '')
        return
      ), this
      return

    toggle: (name) ->
      if @contains(name) then @remove(name) false else @add(name) true

    contains: (name) ->
      regExp(name).test @element.className

    replace: (oldName, newName) ->
      @remove(oldName)
      @add(newName)

  # IE8/9, Safari
  if !('classList' of Element.prototype)
    Object.defineProperty Element.prototype, 'classList', get: ->
      new ClassList(this)

  # replace() support for others
  if window.DOMTokenList and DOMTokenList::replace == null
    DOMTokenList::replace = ClassList::replace

